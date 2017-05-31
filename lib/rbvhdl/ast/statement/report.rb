module RbVHDL::Ast

  module Statement

    class Report
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_expression
      attr_reader   :_severity
      attr_reader   :_annotation

      def initialize(owner, expression)
        @_owner      = owner
        @_label      = nil
        @_expression = expression
        @_severity   = nil
        @_annotation = Hash.new
      end

      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _severity!(expression)
        @_severity   = RbVHDL::Ast.expression_or_nil(expression)
        return self
      end

    end
  end

  def self.report_statement(owner, expression)
    return RbVHDL::Ast::Statement::Report.new(owner, RbVHDL::Ast.expression_or_nil(expression))
  end
  
end

