module RbVHDL::Ast

  module Declaration
    #
    # alias_declaration : "alias" ( identifier | character_literal | operator_symbol ) [ ":" sybtype_indication ] "is" name [signature] ":"
    #
    class Alias
      attr_reader   :_owner
      attr_reader   :_identifier          # RbVHDL::Ast::Identifer | RbVHDL::Ast::Expression::CharacterLiteral | RbVHDL::Ast::Expression::OperatorSymbol
      attr_reader   :_name                # RbVHDL::Ast::Expression::Name
      attr_reader   :_subtype_indication  # RbVHDL::Ast::Type::Indication | nil
      attr_accessor :_signature           # RbVHDL::Ast::Expression::Signature | nil
      attr_reader   :_annotation

      def initialize(owner, identifier, name, subtype_indication=nil, signature=nil)
        @_owner              = owner
        @_identifier         = identifier
        @_name               = name
        @_subtype_indication = subtype_indication
        @_signature          = signature
        @_annotation         = Hash.new
      end
    end
  end

  def self.alias_declaration(owner, ident, name, type=nil, signature=nil)
    if ident.class == RbVHDL::Ast::Identifier or
       ident.class == RbVHDL::Ast::Expression::OperatorSymbol or
       ident.class == RbVHDL::Ast::Expression::CharacterLiteral then
      identifier = ident
    else
      identifier = RbVHDL::Ast.identifier(ident)
    end
    name               = RbVHDL::Ast.name(name)
    subtype_indication = (type.nil?)? nil : RbVHDL::Ast.subtype_indication(type)
    return RbVHDL::Ast::Declaration::Alias.new(owner, identifier, name, subtype_indication, signature)
  end
  
end
