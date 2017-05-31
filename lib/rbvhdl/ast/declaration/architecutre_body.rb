require_relative '../declaration/methods'
require_relative '../statement/methods'

module RbVHDL::Ast

  module Declaration
    #
    # architecture_body : "architecture" identifier "of" entity_name "is"
    #                         {block_declaration_item}
    #                     "begin"
    #                         {concurrent_statement}
    #                     "end" ["architecture"] [identifier] ";"
    #
    class ArchitectureBody
      attr_reader   :_owner                 # RbVHDL::Ast::DesignUnit
      attr_reader   :_identifier            # RbVHDL::Ast::Identifier
      attr_reader   :_entity_name           # RbVHDL::Ast::Expression::SimpleName
      attr_reader   :_declarative_item_list # Array of RbVHDL::Declaration::*
      attr_reader   :_statement_list        # Array of RbVHDL::Statement::*
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
    entity_name = RbVHDL::Ast.name(entity)
    return RbVHDL::Ast::Declaration::ArchitectureBody.new(owner, identifier, entity_name)
  end

end
