require_relative 'mark'
require_relative 'range'

module RbVHDL::Ast

  module Type

    class Definition
    end

    class IntegerDefinition     < Definition
      attr_reader   :_range     # RbVHDL::Ast::Type::Range
      def initialize(range)
        @_range = range
      end
    end

    class FloatingDefinition    < Definition
      attr_reader   :_range     # RbVHDL::Ast::Type::Range
      def initialize(range)
        @_range = range
      end
    end

    class PhysicalDefinition    < Definition
      attr_reader   :_range     # RbVHDL::Ast::Type::Range
      attr_reader   :_unit      # RbVHDL::Identifier
      attr_reader   :_unit_list # Array of [ RbVHDL::Identifier, RbVHDL::Expression::PhysicalLiteral ]
      def initialize(range, unit, unit_list)
        @_range     = range
        @_unit      = unit
        @_unit_list = unit_list
      end
      def _unit!(ident, name)
        @_unit_list.push([RbVHDL.identifier(ident), name])
      end
    end

    class ArrayDefinition       < Definition
      attr_reader   :_range_list         # Array of (RbVHDL::Ast::Type::Mark or RbVHDL::Ast::Type::Range)
      attr_reader   :_subtype_indication # RbVHDL::Ast::Type::Indication
      def initialize(range_list, subtype_indication)
        @_range_list         = range_list
        @_subtype_indication = subtype_indication
      end
    end

    class EnumerationDefinition < Definition
      attr_reader   :_enum_list # Array of RbVHDL::Ast::Identifier
      def initialize(enum_list)
        @_enum_list = enum_list
      end
      def _enum!(identifier)
        @_enum_list.push(RbVHDL::Ast.identifier(identifier))
        return self
      end
    end

    class RecordDefinition      < Definition

      class Field
        attr_reader :_identifier         # RbVHDL::Ast::Identifier
        attr_reader :_subtype_indication # RbVHDL::Ast::Type::Indication
        def initialize(identifier, subtype_indication)
          @_identifier         = identifier
          @_subtype_indication = subtype_indication
        end
      end

      attr_reader   :_field_list # Array of Field

      def initialize
        @_field_list = []
      end
        
      def _field!(identifier, type)
        identifier         = RbVHDL::Ast.identifier(identifier)
        subtype_indication = RbVHDL::Ast.subtype_indication(type)
        @_field_list.push(Field.new(identifier, subtype_indication))
        return self
      end
    end

    class FileDefinition        < Definition
      attr_reader   :_type_mark # RbVHDL::Ast::Type::Mark
      def initialize(type_mark)
        @_type_mark = type_mark
      end
    end

    class AccessDefinition      < Definition
      attr_reader   :_subtype_indication # RbVHDL::Ast::Type::Indication
      def initialize(subtype_indication)
        @_subtype_indication = subtype_indication
      end
    end

  end

  def self.integer_type_definition(range)
    if    range.class < RbVHDL::Ast::Type::Range then
      return RbVHDL::Ast::Type::IntegerDefinition.new(range)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{range.inspect}:#{range.class})"
    end
  end
  
  def self.floating_type_definition(range)
    if    range.class < RbVHDL::Ast::Type::Range then
      return RbVHDL::Ast::Type::FloatingDefinition.new(range)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{range.inspect}:#{range.class})"
    end
  end
  
  def self.physical_type_definition(range, unit, units=nil)
    argument_error = false
    if units.nil? then
      _units = []
    elsif units.class == Array then
      _units = []
      units.each do |unit|
        if unit.size == 2 then
          if unit[1].class == RbVHDL::Ast::Expression::PhysicalLiteral then
            _units.push([RbVHDL::Ast.identifier(unit[0]), unit[1]])
          else
            argument_error = true
          end
        elsif unit.size == 3 then
          _units.push([RbVHDL::Ast.identifier(unit[0]), RbVHDL::Ast.physical_literal(unit[1], unit[2])])
        else
          argument_error = true
        end
      end
    else
      argument_error = true
    end
    unless range.class < RbVHDL::Ast::Type::Range then
      argument_error = true
    end
    if argument_error == true then
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{range.inspect}:#{range.class}, #{unit.inspect}:#{unit.class}, #{units.inspect}:#{units.class})"
    end
    return RbVHDL::Ast::Type::PhysicalDefinition.new(range, RbVHDL::Ast.identifier(unit), _units)
  end

  def self.array_type_definition(range, type)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    if  range.class == Array then
      list = range
    else
      list = [range]
    end
    range_list = list.map do |range|
      if    range.class == RbVHDL::Ast::Type::Mark  then
        range
      elsif range.class  < RbVHDL::Ast::Type::Range then 
        range
      else
        raise ArgumentError, "#{self.inspect}.#{__method__}(#{range.inspect}:#{range.class}, #{type.inspect}:#{type.class})"
      end
    end
    return RbVHDL::Ast::Type::ArrayDefinition.new(range_list, subtype_indication)
  end
  
  def self.enumeration_type_definition(enum_list=nil)
    if    enum_list.nil? then
      return RbVHDL::Ast::Type::EnumerationDefinition.new([])
    elsif enum_list.class == Array then
      return RbVHDL::Ast::Type::EnumerationDefinition.new(enum_list.map{|enum| RbVHDL::Ast.identifier(enum)})
    else
      return RbVHDL::Ast::Type::EnumerationDefinition.new([RbVHDL::Ast.identifier(enum)])
    end
  end

  def self.record_type_definition(record=nil)
    type_def = RbVHDL::Ast::Type::RecordDefinition.new
    if    record.nil? then
      return type_def
    elsif record.class == Hash then
      record.each_pair do |ident, type|
        type_def._field!(RbVHDL::Ast.identifier(ident), RbVHDL::Ast.subtype_indication(type))
      end
      return type_def
    else 
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{record.inspect}:#{record.class})"
    end
  end
  
  def self.file_type_definition(type)
    type_mark = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Type::FileDefinition.new(type_mark)
  end

  def self.access_type_definition(type)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    return RbVHDL::Ast::Type::AccessDefinition.new(subtype_indication)
  end
  
end
