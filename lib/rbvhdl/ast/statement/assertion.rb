module RbVHDL::Ast

  module Statement

    class Assertion
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_condition
      attr_reader   :_report
      attr_reader   :_severity
      attr_reader   :_annotation
    
      def initialize(owner, condition)
        @_owner      = owner
        @_label      = nil
        @_postponed  = nil
        @_condition  = condition
        @_report     = nil
        @_severity   = nil
        @_annotation = Hash.new
      end

      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _report!(expression)
        @_report     = RbVHDL::Ast.expression_or_nil(expression)
        return self
      end

      def _severity!(expression)
        @_severity   = RbVHDL::Ast.expression_or_nil(expression)
        return self
      end
    end

  end

  def self.assertion_statement(owner, condition)
    return RbVHDL::Ast::Statement::Assertion.new(owner, RbVHDL::Ast.expression(condition))
  end
  
end

