module RbVHDL::Ast

  module Statement

    class Null
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_annotation

      def initialize(owner)
        @_owner      = owner
        @_label      = nil
        @_annotation = Hash.new
      end

      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end

    end

  end

  def self.null_statement(owner)
    return RbVHDL::Ast::Statement::Null.new(owner)
  end
    
end
