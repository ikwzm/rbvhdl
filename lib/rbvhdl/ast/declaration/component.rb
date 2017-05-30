require_relative '../interface/methods'

module RbVHDL::Ast

  module Declaration
    #
    # component_declaration : "component" identifier ["is"]
    #                            ["generic" ( generic_interface_list ) ";"]
    #                            ["port"    ( port_interface_list    ) ";"]
    #                          "end" "component" [identifier] ";"
    #
    class Component
      attr_reader   :_owner
      attr_reader   :_identifier             # RbVHDL::Ast::Identifier
      attr_reader   :_generic_interface_list # Array of RbVHDL::Ast::Interface::Constant
      attr_reader   :_port_interface_list    # Array of RbVHDL::Ast::Interface::Signal
      attr_reader   :_annotation

      def initialize(owner, identifier)
        @_owner                   = owner
        @_identifier              = identifier
        @_generic_interface_list  = []
        @_port_interface_list     = []
        @_annotation              = Hash.new
      end
    
      include RbVHDL::Ast::Interface::Methods::Generic
      include RbVHDL::Ast::Interface::Methods::Port
    end
  end

  def self.component_declaration(owner, ident)
    identifier = RbVHDL::Ast.identifier(ident)
    return RbVHDL::Ast::Declaration::Component.new(owner, identifier)
  end
    
end
