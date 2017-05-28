module RbVHDL::Ast

  module Declaration

    class Configuration
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_entity_name
      attr_reader   :_annotation

      def initialize(owner, identifier, entity_name)
        @_owner       = owner
        @_identifier  = identifier
        @_entity_name = entity_name
        @_annotation  = Hash.new
      end
    
    end

  end

  def self.configuration_declaration(owner, ident, entity)
    identifier  = RbVHDL::Ast.identifier(ident )
    entity_name = RbVHDL::Ast.identifier(entity)
    return RbVHDL::Ast::Declaration::Configuration.new(owner, identifier, entity_name)
  end

end
