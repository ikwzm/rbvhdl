require_relative '../declaration/methods'
require_relative '../statement/methods'

module RbVHDL::Ast

  module Statement

    class Generate
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_declarative_item_list
      attr_reader   :_statement_list
      attr_reader   :_annotation

      def initialize(owner, label)
        @_owner                 = owner
        @_label                 = label
        @_declarative_item_list = []
        @_statement_list        = []
        @_annotation            = Hash.new
      end

      include RbVHDL::Ast::Declaration::Methods::BlockItem
      include RbVHDL::Ast::Statement::  Methods::Concurrent
    end

    class IfGenerate < Generate
      attr_reader   :_condition
      def initialize(owner, label, condition)
        super(owner, label, condition)
        @_condition = condition
      end
    end

    class ForGenerate < Generate
      attr_reader   :_index_identifier
      attr_reader   :_index_range
      def initialize(owner, label, index_identifier, index_range)
        super(owner, label)
        @_index_identifier = index_identifier
        @_index_range      = index_range
      end
    end

  end

  def self.if_generate_statement(owner, label, condition)
    _label     = RbVHDL::Ast.label(label)
    _condition = RbVHDL::Ast.expression(condition)
    return RbVHDL::Ast::Statement::IfGenerate.new(owner, _label, _condition)
  end

  def self.for_generate_statement(owner, label, index_identifier, index_range)
    _label            = RbVHDL::Ast.label(label)
    _index_identifier = RbVHDL::Ast.identifier(index_identifier)
    if index_range.class < RbVHDL::Ast::Type::Range then
      return RbVHDL::Ast::Statement::ForGenerate.new(owner, _label, _index_identifier, index_range)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{index_range.inspect}:#{index_range.class})"
    end
  end
    
end

