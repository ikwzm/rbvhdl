module RbVHDL::Ast

  module Declaration

    class Alias
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_subtype_indication
      attr_reader   :_name
      attr_accessor :_signature
      attr_reader   :_annotation

      def initialize(owner, identifier, subtype_indication, name, signature)
        @_owner              = owner
        @_identifier         = identifier
        @_subtype_indication = subtype_indication
        @_name               = name
        @_signature          = signature
        @_annotation         = Hash.new
      end
    
    end

  end

  def self.alias_declaration(owner, ident, type, name, signature=nil)
    identifier         = RbVHDL::Ast.identifier(ident)
    subtype_indication = (type.nil?)? nil : RbVHDL::Ast.subtype_indication(type)
    name               = RbVHDL::Ast.name(name)
    return RbVHDL::Ast::Declaration::Alias.new(owner, identifier, subtype_indication, name, signature)
  end
  
end
