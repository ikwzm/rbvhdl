module RbVHDL::Ast

  module Statement

    class Return
      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_expression
      attr_reader   :_annotation

      def initialize(owner, expression)
        @_owner      = owner
        @_label      = nil
        @_expression = expression
        @_annotation = Hash.new
      end
      
      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end
    end

  end

  def self.return_statement(owner, expression=nil)
    return RbVHDL::Ast::Statement::Return.new(owner, RbVHDL::Ast.expression_or_nil(expression))
  end

end
