require_relative '../declaration/methods'
require_relative '../interface/methods'
require_relative '../statement/methods'

module RbVHDL::Ast

  module Declaration

    class Entity
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_generic_interface_list
      attr_reader   :_port_interface_list
      attr_reader   :_declarative_item_list
      attr_reader   :_statement_list
      attr_reader   :_annotation
    
      def initialize(owner, identifier)
        @_owner                  = owner
        @_identifier             = identifier
        @_generic_interface_list = []
        @_port_interface_list    = []
        @_declarative_item_list  = []
        @_statement_list         = []
        @_annotation             = Hash.new
      end

      include RbVHDL::Ast::Declaration::Methods::EntityItem
      include RbVHDL::Ast::Interface::Methods::Generic
      include RbVHDL::Ast::Interface::Methods::Port
      include RbVHDL::Ast::Statement::Methods::Assertion
      include RbVHDL::Ast::Statement::Methods::ProcedureCall
      include RbVHDL::Ast::Statement::Methods::Process
    end

  end

  def self.entity_declaration(owner, identifier)
    return RbVHDL::Ast::Declaration::Entity.new(owner, RbVHDL::Ast.identifier(identifier))
  end
  
end
