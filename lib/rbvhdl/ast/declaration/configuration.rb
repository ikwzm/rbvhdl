require_relative '../declaration/methods'
require_relative '../association/methods'

module RbVHDL::Ast

  module Declaration
    #
    # configuration_declaration   : "configuration" identifier "of" entity_name "is"
    #                                 { use_clause | attribute_specification | group_declaration }
    #                                 block_configuration
    #                               "end" ["configuration"] [identifier] ";"
    #
    class Configuration
      attr_reader   :_owner
      attr_reader   :_identifier            # RbVHDL::Ast::Identifier
      attr_reader   :_entity_name           # RbVHDL::Ast::Expression::SimpleName
      attr_reader   :_declarative_item_list # Array of RbVHDL::Declaration::*
      attr_accessor :_block_configuration   # RbVHDL::Ast::BlockConfiguration | nil
      attr_reader   :_annotation

      def initialize(owner, identifier, entity_name, &block)
        @_owner                 = owner
        @_identifier            = identifier
        @_entity_name           = entity_name
        @_declarative_item_list = []
        @_block_configuration   = nil
        @_annotation            = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end
      include RbVHDL::Ast::Declaration::Methods::UseClause
      include RbVHDL::Ast::Declaration::Methods::AttributeSpec
      include RbVHDL::Ast::Declaration::Methods::Group
    end

    #
    # configuration_specification : "for" component_specification
    #                                 bind_indication ";"
    #
    class ConfigurationSpec
      attr_reader   :_component_spec        # RbVHDL::Ast::Declaration::ComponentSpec
      attr_accessor :_bind_indication       # RbVHDL::Ast::Declaration::BindIndication
      def initialize(component_spec)
        @_component_spec  = component_spec
        @_bind_indication = nil
      end
    end

    #
    # component_configuration     : "for" component_specification
    #                                 [ bind_indication ";" ]
    #                                 [ block_configuration ]
    #                               "end" "for" ";"
    #
    class ComponentConfiguration
      attr_reader   :_component_spec        # RbVHDL::Ast::Declaration::ComponentSpec
      attr_accessor :_bind_indication       # RbVHDL::Ast::Declaration::BindIndication     | nil
      attr_accessor :_block_configuration   # RbVHDL::Ast::Declaration::BlockConfiguration | nil
      def initialize(component_spec)
        @_component_spec      = component_spec
        @_bind_indication     = nil
        @_block_configuration = nil
      end
    end

    #
    # component_specification     : (label ["," label]* | "others" | "all") ":" component_name
    #
    class ComponentSpec
      attr_reader   :_name                  # RbVHDL::Ast::Expression::SimpleName
      def initialize(name)
        @_name = name
      end
    end

    class ComponentSpecLabels < ComponentSpec
      attr_reader   :_label_list            # Array of RbVHDL::Ast::Label
      def initialize(name, label_list=[])
        super(name)
        @_label_list = label_list
      end
    end

    class ComponentSpecOthers < ComponentSpec
      def initialize(name)
        super(name)
      end
    end

    class ComponentSpecAll    < ComponentSpec
      def initialize(name)
        super(name)
      end
    end

    #
    # block_configuration         : "for" ( architecutre_name | block_statement_label | generate_statement_label )
    #                                 { use_clause }
    #                                 { block_configuration | component_configuration }
    #                               "end" "for" ";"
    #
    class BlockConfiguration
      attr_reader   :_label                 # RbVHDL::Ast::Expression::SimpleName
      attr_reader   :_declarative_item_list # Array of RbVHDL::Declaration::UseClause
      attr_reader   :_configuration_list    # Array of RbVHDL::Ast::BlockConfiguration | RbVHDL::Ast::ComponentConfiguration
      def initialize(label, &block)
        @_label                 = label
        @_declarative_item_list = []
        @_configuration_list    = []
        if block_given? then
          self.instance_eval(&block)
        end
      end
      include RbVHDL::Ast::Declaration::Methods::UseClause
      def _block_configuration(label, &block)
        config = RbVHDL::Ast.block_configuration(label, &block)
        @_configuration_list.push(config)
        return config
      end
      def _component_configuration(spec)
        config = RbVHDL::Ast.component_configuration(spec)
        @_configuration_list.push(config)
        return config
      end
    end

    #
    # bind_indication             : "use" (  "entity" entity_name [ "(" architeture_identifier ")" ]
    #                                      | "configuration" configuration_name
    #                                      | "open"
    #                                     )
    #                                 [ "generic" "map" "(" generic_association_list ")" ]
    #                                 [ "port"    "map" "(" port_association_list    ")" ]
    #
    class BindIndication
      attr_reader   :_generic_association_list
      attr_reader   :_port_association_list
      def initialize(&block)
        @_generic_association_list = []
        @_port_association_list    = []
        if block_given? then
          self.instance_eval(&block)
        end
      end
      include RbVHDL::Ast::Association::Methods::Generic
      include RbVHDL::Ast::Association::Methods::Port
    end

    class EntityBindIndication < BindIndication
      attr_reader   :_name               # RbVHDL::Ast::Expression::SimpleName
      attr_reader   :_architecture_name  # RbVHDL::Ast::Expression::SimpleName | nil
      def initialize(name, architecture_name=nil, &block)
        super(&block)
        @_name              = name
        @_architecture_name = architecture_name
      end
    end

    class ConfigurationBindIndication < BindIndication
      attr_reader   :_name               # RbVHDL::Ast::Expression::SimpleName
      def initialize(name, &block)
        super(&block)
        @_name = name
      end
    end

    class OpenBindIndication < BindIndication
      def initialize(&block)
        super(&block)
      end
    end
    
  end

  def self.configuration_declaration(owner, ident, entity, &block)
    identifier  = RbVHDL::Ast.identifier(ident)
    entity_name = RbVHDL::Ast.name(entity)
    return RbVHDL::Ast::Declaration::Configuration.new(owner, identifier, entity_name, &block)
  end

  def self.configuration_specification(spec)
    if spec.class <  RbVHDL::Ast::Declaration::ComponentSpec then
      return RbVHDL::Ast::Declaration::ConfigurationSpec.new(spec)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{spec.inspect}:#{spec.class})"
    end
  end

  def self.component_configuration(spec)
    if spec.class <  RbVHDL::Ast::Declaration::ComponentSpec then
      return RbVHDL::Ast::Declaration::ComponentConfiguration.new(spec)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{spec.inspect}:#{spec.class})"
    end
  end

  def self.block_configuration(label, &block)
    return RbVHDL::Ast::Declaration::BlockConfiguration.new(RbVHDL::Ast.name(label), &block)
  end

  def self.component_specification(name, labels=nil)
    _name = RbVHDL::Ast.name(name)
    if    labels.nil? then
      return RbVHDL::Ast::Declaration::ComponentSpecLabels.new(_name)
    elsif labels.class == Array then
      return RbVHDL::Ast::Declaration::ComponentSpecLabels.new(_name, labels.map{ |label| RbVHDL::Ast.name(label)})
    else
      return RbVHDL::Ast::Declaration::ComponentSpecLabels.new(_name, [RbVHDL::Ast.name(labels)])
    end
  end

  def self.component_specification_others(name)
    return RbVHDL::Ast::Declaration::ComponentSpecOthers.new(RbVHDL::Ast.name(name))
  end
    
  def self.component_specification_all(name)
    return RbVHDL::Ast::Declaration::ComponentSpecAll.new(RbVHDL::Ast.name(name))
  end
    
  def self.entity_bind_indication(name, architecture_name=nil, &block)
    _name              = RbVHDL::Ast.name(name)
    _architecture_name = (architecture_name.nil?)? nil : RbVHDL::Ast.name(architecture_name)
    return RbVHDL::Ast::Declaration::EntityBindIndication.new(_name, _architecture_name, &block)
  end

  def self.configuration_bind_indication(name, &block)
    return RbVHDL::Ast::Declaration::ConfigurationBindIndication.new(RbVHDL::Ast.name(name), &block)
  end

  def self.open_bind_indication(&block)
    return RbVHDL::Ast::Declaration::OpenBindIndication.new(&block)
  end

end
