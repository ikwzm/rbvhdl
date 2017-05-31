require_relative '../association/methods'

module RbVHDL::Ast

  module Statement

    class ComponentInstantiation
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_name
      attr_reader   :_generic_association_list
      attr_reader   :_port_association_list
      attr_reader   :_annotation
    
      def initialize(owner, label, component_name)
        @_owner                    = owner
        @_label                    = label
        @_name                     = component_name
        @_generic_association_list = []
        @_port_association_list    = []
        @_annotation               = Hash.new
      end

      include RbVHDL::Ast::Association::Methods::Generic
      include RbVHDL::Ast::Association::Methods::Port

    end

    class EntityInstantiation < ComponentInstantiation
      attr_reader   :_architecture_identifier
      def initialize(owner, label, entity_name, architecture_name)
        super(owner, label, name)
        @_architecture_identifier = RbVHDL::Ast.label(architecture_name)
      end
    end

  end

  def self.component_instantiation_statement(owner, label, component_name)
    _label           = RbVHDL::Ast.label(label)
    _component_name  = RbVHDL::Ast.identifier(component_name)
    return RbVHDL::Ast::Statement::ComponentInstantiation.new(owner, _label, _component_name)
  end

  def self.entity_instantiation_statement(owner, label, entity_name, architecture_name)
    _label             = RbVHDL::Ast.label(label)
    _entity_name       = RbVHDL::Ast.identifier(entity_name)
    _architecture_name = RbVHDL::Ast.identifier(architecture_name)
    return RbVHDL::Ast::Statement::EntityInstantiation.new(owner, _label, _entity_name, _architecture_name)
  end
  
end

