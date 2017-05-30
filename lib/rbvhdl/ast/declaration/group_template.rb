module RbVHDL::Ast

  module Declaration
    #
    # group_template_declaration : "group" identifier "is" "(" entity_class ["<>"] ["," entity_class ["<>"]* ")" ";"
    #
    class GroupTemplate
      attr_reader   :_owner
      attr_reader   :_identifier          # RbVHDL::Ast::Identifer
      attr_reader   :_entity_class_list   # Array of Symbol
      
      def initialize(owner, identifier, entity_class_list=[])
        @_owner              = owner
        @_identifier         = identifier
        @_entity_class_list  = entity_class_list
      end
    end
  end

  def self.group_template_declaration(owner, identifier, entity_class_list=[])
    _identifier = RbVHDL::Ast.identifier(identifier)
    return RbVHDL::Ast::Declaration::GroupTemplate.new(owner, _identifier, entity_class_list)
  end

end
