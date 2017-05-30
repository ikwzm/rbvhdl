module RbVHDL::Ast

  module Declaration
    #
    # alias_declaration : "alias" ( identifier | character_literal | operator_symbol ) [ ":" sybtype_indication ] "is" name [signature] ":"
    #
    class Alias
      attr_reader   :_owner
      attr_reader   :_identifier          # RbVHDL::Ast::Identifer | RbVHDL::Ast::Expression::CharacterLiteral
      attr_reader   :_subtype_indication  # RbVHDL::Ast::Type::Indication
      attr_reader   :_name                # RbVHDL::Ast::Expression::Name
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
