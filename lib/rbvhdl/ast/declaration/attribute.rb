module RbVHDL::Ast

  module Declaration
    #
    # attribute_declaration : "attribute" identifier ":" type_mark ";"
    # 
    class AttributeDecl
      attr_reader   :_owner
      attr_reader   :_identifier  # RbVHDL::Ast::Identifier
      attr_reader   :_type_mark   # RbVHDL::Ast::Type::Mark
      attr_reader   :_annotation
    
      def initialize(owner, identifier, type_mark)
        @_owner            = owner
        @_identifier       = identifier
        @_type_mark        = type_mark
        @_annotation       = Hash.new
      end
    end

    #
    # attribute_specification : "attribute" identifier "of" entity_name_list ":" entity_class "is" expression ";"
    # 
    class AttributeSpec
      attr_reader   :_owner
      attr_reader   :_identifier        # RbVHDL::Ast::Identifier
      attr_reader   :_entity_name_list  # Array of RbVHDL::Ast::Identifier
      attr_reader   :_entity_class      # Symbol
      attr_reader   :_value_expression  # RbVHDL::Ast::Expression
      attr_reader   :_annotation

      def initialize(owner, identifier, entity_name_list, entity_class, value_expression)
        @_owner            = owner
        @_identifier       = identifier
        @_entity_name_list = entity_name_list
        @_entity_class     = entity_class
        @_value_expression = value_expression
        @_annotation       = Hash.new
      end
    end
  end

  def self.attrbute_declaration(owner, ident, type)
    identifier = RbVHDL::Ast.identifier(ident)
    type_mark  = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Declaration::AttributeDecl.new(owner, identifier, type_mark)
  end

  def self.attribute_specification(owner, ident, entity_name, entity_class, value)
    identifier       = RbVHDL::Ast.identifier(ident)
    entity_name_list = RbVHDL::Ast.identifier_list(entity_name)
    value_expression = RbVHDL::Ast.expression(value)
    return RbVHDL::Ast::Declaration::AttributeSpec(owner, identifier, entity_name_list, entity_class, value_expression)
  end
  
end

