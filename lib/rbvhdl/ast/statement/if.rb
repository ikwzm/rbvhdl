require_relative '../statement/methods'

module RbVHDL::Ast

  module Statement

    class If
      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_condition
      attr_reader   :_statement_list
      attr_reader   :_else_list
      attr_reader   :_annotation

      include RbVHDL::Ast::Statement::Methods::Sequential

      def initialize(owner, condition)
        @_owner          = owner
        @_label          = nil
        @_condition      = condition
        @_statement_list = []
        @_else_list      = []
        @_annotation     = Hash.new
      end

      def _label!(label)
        @_label          = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _elsif_statement(condition, owner=self)
        else_statement = RbVHDL::Ast::Statement::Elsif.new(owner, RbVHDL::Ast.expression(condition))
        @_else_list.push(else_statement)
        return else_statement
      end

      def _else_statement(owner=self)
        else_statement = RbVHDL::Ast::Statement::Else.new(owner)
        @_else_list.push(else_statement)
        return else_statement
      end
    end

    class Elsif
      attr_reader   :_owner
      attr_accessor :_condition
      attr_reader   :_statement_list
      attr_reader   :_annotation

      def initialize(owner, condition)
        @_owner          = owner
        @_condition      = condition
        @_statement_list = []
        @_annotation     = Hash.new
      end

      include RbVHDL::Ast::Statement::Methods::Sequential
    end

    class Else
      attr_reader   :_owner
      attr_reader   :_statement_list
      attr_reader   :_annotation

      def initialize(owner)
        @_owner          = owner
        @_statement_list = []
        @_annotation     = Hash.new
      end

      include RbVHDL::Ast::Statement::Methods::Sequential
    end

  end

  def self.if_statement(owner, condition)
    return RbVHDL::Ast::Statement::If.new(owner, RbVHDL::Ast.expression(condition))
  end

end

