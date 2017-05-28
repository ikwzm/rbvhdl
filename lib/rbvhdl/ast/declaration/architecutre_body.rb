require_relative '../declaration/methods'
require_relative '../statement/methods'

module RbVHDL::Ast

  module Declaration

    class ArchitectureBody
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_entity_name
      attr_reader   :_declarative_item_list
      attr_reader   :_statement_list
      attr_reader   :_annotation

      def initialize(owner, identifier, entity_name)
        @_owner                 = owner
        @_identifier            = identifier
        @_entity_name           = entity_name
        @_declarative_item_list = []
        @_statement_list        = []
        @_annotation            = Hash.new
      end
    
      include RbVHDL::Ast::Declaration::Methods::BlockItem
      include RbVHDL::Ast::Statement::Methods::Concurrent
    end

  end

  def self.architecture_body(owner, ident, entity)
    identifier  = RbVHDL::Ast.identifier(ident )
    entity_name = RbVHDL::Ast.identifier(entity)
    return RbVHDL::Ast::Declaration::ArchitectureBody.new(owner, identifier, entity_name)
  end

end
