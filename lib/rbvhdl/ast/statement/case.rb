require_relative '../statement/methods'

module RbVHDL::Ast

  module Statement

    class Case

      class When
        attr_reader   :_owner
        attr_accessor :_choices
        attr_reader   :_statement_list
        attr_reader   :_annotation
        def initialize(owner, choices, &block)
          @_owner          = owner
          @_choices        = choices
          @_statement_list = []
          @_annotation     = Hash.new
          if block_given? then
            self.instance_eval(&block)
          end
        end
        include RbVHDL::Ast::Statement::Methods::Sequential
      end

      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_expression
      attr_reader   :_when_list
      attr_reader   :_annotation
  
      def initialize(owner, expression, &block)
        @_owner      = owner
        @_label      = nil
        @_expression = expression
        @_when_list  = []
        @_annotation = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      def _label!(label, &block)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      def _when(choices, &block)
        when_statement = When.new(self, RbVHDL::Ast.choices(choices), &block)
        @_when_list.push(when_statement)
        return when_statement
      end
    end

  end

  def self.case_statement(owner, expression, &block)
    return RbVHDL::Ast::Statement::Case.new(owner, RbVHDL::Ast.expression(expression), &block)
  end

end
