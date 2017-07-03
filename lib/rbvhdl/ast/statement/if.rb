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

      def initialize(owner, condition, &block)
        @_owner          = owner
        @_label          = nil
        @_condition      = condition
        @_statement_list = []
        @_else_list      = []
        @_annotation     = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      def _label!(label, &block)
        @_label = RbVHDL::Ast.label_or_nil(label)
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      def _elsif!(condition, &block)
        _elsif_statement(condition, self, &block)
        return self
      end

      def _else!(&block)
        _else_statement(self, &block)
        return self
      end

      def _elsif_statement(condition, owner=self, &block)
        else_statement = RbVHDL::Ast::Statement::Elsif.new(owner, RbVHDL::Ast.expression(condition), &block)
        @_else_list.push(else_statement)
        return else_statement
      end

      def _else_statement(owner=self, &block)
        else_statement = RbVHDL::Ast::Statement::Else.new(owner, &block)
        @_else_list.push(else_statement)
        return else_statement
      end
    end

    class Elsif
      attr_reader   :_owner
      attr_accessor :_condition
      attr_reader   :_statement_list
      attr_reader   :_annotation

      def initialize(owner, condition, &block)
        @_owner          = owner
        @_condition      = condition
        @_statement_list = []
        @_annotation     = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      include RbVHDL::Ast::Statement::Methods::Sequential
    end

    class Else
      attr_reader   :_owner
      attr_reader   :_statement_list
      attr_reader   :_annotation

      def initialize(owner, &block)
        @_owner          = owner
        @_statement_list = []
        @_annotation     = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      include RbVHDL::Ast::Statement::Methods::Sequential
    end

  end

  def self.if_statement(owner, condition, &block)
    return RbVHDL::Ast::Statement::If.new(owner, RbVHDL::Ast.expression(condition), &block)
  end

end
