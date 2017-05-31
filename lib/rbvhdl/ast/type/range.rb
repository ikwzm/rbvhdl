require_relative '../expression/simple_expression'
require_relative '../expression/name'

module RbVHDL::Ast

  module Type

    class Range
    end

    class RangeAttribute < Range
      attr_reader :_name     # RbVHDL::Ast::Expression::AttributeName
      def initialize(name)
        @_name = name
      end
    end

    class RangeTo        < Range
      attr_reader :_l_expr   # RbVHDL::Ast::Expression::SimpleExpression
      attr_reader :_r_expr   # RbVHDL::Ast::Expression::SimpleExpression
      def initialize(l_expr, r_expr)
        @_l_expr = l_expr
        @_r_expr = r_expr
      end
    end

    class RangeDownto    < Range
      attr_reader :_l_expr   # RbVHDL::Ast::Expression::SimpleExpression
      attr_reader :_r_expr   # RbVHDL::Ast::Expression::SimpleExpression
      def initialize(l_expr, r_expr)
        @_l_expr = l_expr
        @_r_expr = r_expr
      end
    end

  end

  def self.range_attr(name)
    if name.class == RbVHDL::Ast::Expression::AttributeName then
      return RbVHDL::Ast::Type::RangeAttribute.new(name)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{name.inspect}:#{name.class})"
    end
  end

  def self.range_to(l,r)
    l_expr = RbVHDL::Ast.simple_expression(l)
    r_expr = RbVHDL::Ast.simple_expression(r)
    return RbVHDL::Ast::Type::RangeTo.new(l_expr, r_expr)
  end

  def self.range_downto(l,r)
    l_expr = RbVHDL::Ast.simple_expression(l)
    r_expr = RbVHDL::Ast.simple_expression(r)
    return RbVHDL::Ast::Type::RangeDownto.new(l_expr, r_expr)
  end

end
