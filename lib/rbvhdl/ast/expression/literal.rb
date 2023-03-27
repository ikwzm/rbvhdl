require_relative 'primary'

module RbVHDL::Ast

  class Expression
    #
    # literal           : decimal_literal
    #                   | based_literal
    #                   | physical_literal
    #                   | identifier
    #                   | character_litral
    #                   | string_litral
    #                   | bit_string_litral
    #                   | null
    #
    class Literal < Primary
    end
    #
    # decimal_literal   : integer [ "." ingeger ][ exponent ]
    #
    class DecimalLiteral   < Literal
      attr_reader   :_integer
      attr_reader   :_fraction
      attr_reader   :_exponent
      def initialize(integer)
        super()
        @_integer  = integer
        @_fraction = nil
        @_exponent = nil
      end
      def _fraction!(fraction)
        @_fraction = fraction
        return self
      end
      def _exponent!(num, sign=nil)
        @_exponent = RbVHDL::Ast.exponent(num, sign)
        return self
      end
      def _to_physical_literal(unit_name)
        return RbVHDL::Ast::Expression::PhysicalLiteral.new(self, RbVHDL::Ast.name(unit_name))
      end
      def _to_based_literal(base)
        based_literal = RbVHDL::Ast::Expression::BasedLiteral.new(base, @_integer.to_s)
        based_literal._point(@_fraction) unless @_fraction.nil?
        based_literal._exp(  @_exponent) unless @_exponent.nil?
        return based_literal
      end
    end
    #
    # based_literal     | integer "#" based_integer [ "." based_integer ] "#" [ exponent ]
    # 
    class BasedLiteral     < DecimalLiteral
      attr_reader   :_base
      def initialize(base, integer)
        super(integer)
        @_base = base
      end
    end
    #
    # exponent          : "E"     integer
    #                   | "E" "+" integer
    #                   | "E" "-" integer
    #
    class Exponent
      attr_reader   :_number
      attr_reader   :_sign
      def initialize(num, sign = nil)
        if num < 0 then
          @_number = num
          @_sign   = :"-"
        elsif sign == true then
          @_number = num
          @_sign   = :"+"
        else
          @_number = num
          @_sign   = nil
        end
      end
    end
    #
    # physical_literal  : unit_name
    #                   | decimal_literal unit_name
    #                   | based_literal   unit_name
    #
    class PhysicalLiteral  < Literal
      attr_reader   :_decimal
      attr_reader   :_unit_name
      def initialize(decimal, unit_name)
        super()
        @_decimal   = decimal
        @_unit_name = unit_name
      end
    end
    #
    # character_literal : "'" graphic_character "'"
    #
    class CharacterLiteral < Literal
      attr_reader   :_value
      def initialize(value)
        super()
        @_value = value
      end
    end
    #
    # string_literal    : """ {graphic_character} """
    #
    class StringLiteral    < Literal
      attr_reader   :_value
      def initialize(value)
        super()
        @_value = value
      end
    end
    #
    # bit_string_literal: [ integer ] ("B" | "O" | "X") """ {graphic_character} """
    #
    class BitStringLiteral < Literal
      attr_reader   :_width
      attr_reader   :_base
      attr_reader   :_value
      def initialize(width, base, value)
        super()
        @_width = width
        @_base  = base
        @_value = value
      end
    end
    #
    # null
    #
    class NullLiteral      < Literal
    end

  end

  def self.numeric_expression(num)
    if num.class < Numeric then
      if num < 0 then
        return RbVHDL::Ast.unary_minus(RbVHDL::Ast.decimal_literal(num.abs))
      else
        return RbVHDL::Ast.decimal_literal(num)
      end
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{num.inspect}:#{num.class})"
    end      
  end

  def self.decimal_literal(num)
    if    num.class == RbVHDL::Ast::Expression::DecimalLiteral then
      return num
    elsif num.class <  Integer and num >= 0  then # for Ruby 2.3.7 or earlier
      return RbVHDL::Ast::Expression::DecimalLiteral.new(num)
    elsif num.class == Integer and num >= 0  then # for Ruby 2.4.0 or later 
      return RbVHDL::Ast::Expression::DecimalLiteral.new(num)
    elsif num.class == Float  and num >= 0.0 then
      str     = num.to_s
      match   = str.match(/^(-?\d*)(.*)/)
      literal = RbVHDL::Ast::Expression::DecimalLiteral.new(match[1])
      str     = match[2]
      match   = str.match(/^\.(\d+)(.*)/)
      unless match.nil? then
        literal._fraction!(match[1])
        str   = match[2]
      end
      match   = str.match(/^[eE]([-+]?\d+)/)
      unless match.nil? then
        literal._exponent!(match[1].to_i, true)
        str   = match[2]
      end
      return literal
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{num.inspect}:#{num.class})"
    end
  end

  def self.based_literal(base, num)
    if    num.class == RbVHDL::Ast::Expression::DecimalLiteral then
      return num.to_based_literal(base)
    elsif num.class == String then
      return RbVHDL::Ast::Expression::BasedLiteral.new(base, num)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{base.inspect}:#{base.class},#{num.inspect}:#{num.class})"
    end
  end

  def self.exponent(num, sign=nil)
    if    num.class == RbVHDL::Ast::Expression::Exponent
      return num
    elsif num.class <  Integer or   # for Ruby 2.3.7 or earlier
          num.class == Integer then # for Ruby 2.4.0 or later 
      return RbVHDL::Ast::Expression::Exponent.new(num, sign)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{base.inspect}:#{base.class},#{num.inspect}:#{num.class})"
    end
  end

  def self.physical_literal(num, name)
    if  num.nil? or
        num.class == RbVHDL::Ast::Expression::DecimalLiteral or
        num.class == RbVHDL::Ast::Expression::BasedLiteral   then
      decimal = num
    else
      decimal = RbVHDL::Ast.decimal_literal(num)
    end
    unit_name = RbVHDL::Ast.name(name)
    return RbVHDL::Ast::Expression::PhysicalLiteral.new(decimal, unit_name)
  end

  def self.character_literal(value)
    return RbVHDL::Ast::Expression::CharacterLiteral.new(value)
  end

  def self.string_literal(value)
    return RbVHDL::Ast::Expression::StringLiteral.new(value)
  end

  def self.bit_string_literal(width, base, value)
    return RbVHDL::Ast::Expression::BitStringLiteral.new(width, base, value)
  end

  def self.null_literal
    return RbVHDL::Ast::Expression::NullLiteral.new
  end
  
end
