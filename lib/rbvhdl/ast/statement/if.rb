require_relative '../statement/methods'

module RbVHDL::Ast

  module Statement

    class If
      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_condition
      attr_reader   :_statement_list
      attr_reader   :_else
      attr_reader   :_annotation

      def initialize(owner, condition)
        @_owner          = owner
        @_label          = nil
        @_condition      = condition
        @_statement_list = []
        @_else           = nil
        @_annotation     = Hash.new
      end

      def _label!(label)
        @_label          = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      include RbVHDL::Ast::Statement::Methods::Sequential

      def _elsif_statement(condition, owner=self)
        if @_else.nil? then
          @_else = RbVHDL::Ast::Statement::If.new(owner, RbVHDL::Ast.expression(condition))
          return @_else
        else
          return @_else._elsif_statement(condtion, owner)
        end
      end

      def _else_statement(owner=self)
        if @_else.nil? then
          @_else = RbVHDL::Ast::Statement::If.new(owner, nil)
          return @_else
        else
          return @_else._else_statement(owner)
        end
      end
    end

  end

  def self.if_statement(owner, condition)
    return RbVHDL::Ast::Statement::If.new(owner, RbVHDL::Ast.expression(condition))
  end

end

