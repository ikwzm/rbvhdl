module RbVHDL::Ast
  module Declaration

    class AttributeDecl
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_type_mark
      attr_reader   :_annotation
    
      def initialize(owner, identifier, type_mark)
        @_owner            = owner
        @_identifier       = identifier
        @_type_mark        = type_mark
        @_annotation       = Hash.new
      end
    end

    class AttributeSpec
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_entity_name_list
      attr_reader   :_entity_class
      attr_reader   :_value_expression
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

