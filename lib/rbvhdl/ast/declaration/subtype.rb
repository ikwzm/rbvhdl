module RbVHDL::Ast

  module Declaration

    class SubtypeDecl
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_subtype_indication
      attr_reader   :_annotation

      def initialize(owner, identifier, subtype_indication)
        @_owner              = owner
        @_identifier         = identifier
        @_subtype_indication = subtype_indication
        @_annotation         = Hash.new
      end

    end
  end

  def self.subtype_declaration(owner, ident, type)
    identifier         = RbVHDL::Ast.identifier(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    return RbVHDL::Ast::Declaration::SubtypeDecl.new(owner, identifier, subtype_indication)
  end
 
end

