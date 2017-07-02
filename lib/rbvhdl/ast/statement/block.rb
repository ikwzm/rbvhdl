require_relative '../statement/methods'
require_relative '../interface/methods'
require_relative '../declaration/methods'
require_relative '../association/methods'

module RbVHDL::Ast

  module Statement

    class Block
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_gurard_expression
      attr_reader   :_generic_interface_list
      attr_reader   :_generic_association_list
      attr_reader   :_port_interface_list
      attr_reader   :_port_association_list
      attr_reader   :_declarative_item_list
      attr_reader   :_statement_list
      attr_reader   :_annotation
    
      def initialize(owner, label, &block)
        @_owner                    = owner
        @_label                    = label
        @_gurard_expression        = nil
        @_generic_interface_list   = []
        @_generic_association_list = []
        @_port_interface_list      = []
        @_port_association_list    = []
        @_declarative_item_list    = []
        @_statement_list           = []
        @_annotation               = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      include RbVHDL::Ast::Interface::Methods::Generic
      include RbVHDL::Ast::Interface::Methods::Port
      include RbVHDL::Ast::Association::Methods::Generic
      include RbVHDL::Ast::Association::Methods::Port
      include RbVHDL::Ast::Declaration::Methods::BlockItem
      include RbVHDL::Ast::Statement::Methods::Concurrent
    end

  end

  def self.block_statement(owner, label, &block)
    return RbVHDL::Ast::Statement::Block.new(owner, RbVHDL::Ast.label(label), &block)
  end
  
end
