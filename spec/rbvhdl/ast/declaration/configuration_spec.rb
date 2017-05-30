require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Configuration' do

  describe 'ComponentSpecLabels' do
    context "new" do

      it "new(identifier('component_spec'))" do
        spec = RbVHDL::Ast::Declaration::ComponentSpecLabels.new(RbVHDL::Ast.identifier('component_spec'))
        expect(spec.class               ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._name.class         ).to eq RbVHDL::Ast::Identifier
        expect(spec._name               ).to eq :component_spec
        expect(spec._label_list         ).to eq []
      end

      it "new(identifier('component_spec'), [identifier('U0'),identifier('U1')])" do
        spec = RbVHDL::Ast::Declaration::ComponentSpecLabels.new(RbVHDL::Ast.identifier('component_spec'),[RbVHDL::Ast.identifier('U0'), RbVHDL::Ast.identifier('U1')])
        expect(spec.class               ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._name.class         ).to eq RbVHDL::Ast::Identifier
        expect(spec._name               ).to eq :component_spec
        expect(spec._label_list.size    ).to eq 2
        expect(spec._label_list[0].class).to eq RbVHDL::Ast::Identifier
        expect(spec._label_list[0]      ).to eq :U0
        expect(spec._label_list[1].class).to eq RbVHDL::Ast::Identifier
        expect(spec._label_list[1]      ).to eq :U1
      end

      it "RbVHDL::Ast.component_specification('component_spec')" do
        spec = RbVHDL::Ast.component_specification('component_spec')
        expect(spec.class               ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._name.class         ).to eq RbVHDL::Ast::Identifier
        expect(spec._name               ).to eq :component_spec
        expect(spec._label_list         ).to eq []
      end
        
      it "RbVHDL::Ast.component_specification('component_spec', 'U0')" do
        spec = RbVHDL::Ast.component_specification('component_spec', 'U0')
        expect(spec.class               ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._name.class         ).to eq RbVHDL::Ast::Identifier
        expect(spec._name               ).to eq :component_spec
        expect(spec._label_list.size    ).to eq 1
        expect(spec._label_list[0].class).to eq RbVHDL::Ast::Identifier
        expect(spec._label_list[0]      ).to eq :U0
      end
        
      it "RbVHDL::Ast.component_specification('component_spec', ['U0', 'U1'])" do
        spec = RbVHDL::Ast.component_specification('component_spec', ['U0', 'U1'])
        expect(spec.class               ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._name.class         ).to eq RbVHDL::Ast::Identifier
        expect(spec._name               ).to eq :component_spec
        expect(spec._label_list.size    ).to eq 2
        expect(spec._label_list[0].class).to eq RbVHDL::Ast::Identifier
        expect(spec._label_list[0]      ).to eq :U0
        expect(spec._label_list[1].class).to eq RbVHDL::Ast::Identifier
        expect(spec._label_list[1]      ).to eq :U1
      end
    end
  end

  describe 'ComponentSpecOthers' do
    context "new" do

      it "new(identifier('component_spec'))" do
        spec = RbVHDL::Ast::Declaration::ComponentSpecOthers.new(RbVHDL::Ast.identifier('component_spec'))
        expect(spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecOthers
        expect(spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(spec._name      ).to eq :component_spec
      end

      it "RbVHDL::Ast.component_specification_others('component_spec')" do
        spec = RbVHDL::Ast.component_specification_others('component_spec')
        expect(spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecOthers
        expect(spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(spec._name      ).to eq :component_spec
      end

    end
  end

  describe 'ComponentSpecAll' do
    context "new" do

      it "new(identifier('component_spec'))" do
        spec = RbVHDL::Ast::Declaration::ComponentSpecAll.new(RbVHDL::Ast.identifier('component_spec'))
        expect(spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecAll
        expect(spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(spec._name      ).to eq :component_spec
      end

      it "RbVHDL::Ast.component_specification_all('component_spec')" do
        spec = RbVHDL::Ast.component_specification_all('component_spec')
        expect(spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecAll
        expect(spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(spec._name      ).to eq :component_spec
      end

    end
  end

  describe 'EntityBindIndication' do
    context "new" do

      it "new(identifier('entity_name'))" do
        bind = RbVHDL::Ast::Declaration::EntityBindIndication.new(RbVHDL::Ast.identifier('entity_name'))
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :entity_name
        expect(bind._architecture_name       ).to eq nil
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end
      
      it "new(identifier('entity_name'), identifier('arch_name'))" do
        bind = RbVHDL::Ast::Declaration::EntityBindIndication.new(RbVHDL::Ast.identifier('entity_name'), RbVHDL::Ast.identifier('arch_name'))
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :entity_name
        expect(bind._architecture_name.class ).to eq RbVHDL::Ast::Identifier
        expect(bind._architecture_name       ).to eq :arch_name
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end

      it "RbVHDL::Ast.entity_bind_indication('entity_name')" do
        bind = RbVHDL::Ast.entity_bind_indication('entity_name')
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :entity_name
        expect(bind._architecture_name       ).to eq nil
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end
      
      it "RbVHDL::Ast.entity_bind_indication('entity_name', 'arch_name')" do
        bind = RbVHDL::Ast.entity_bind_indication('entity_name', 'arch_name')
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :entity_name
        expect(bind._architecture_name.class ).to eq RbVHDL::Ast::Identifier
        expect(bind._architecture_name       ).to eq :arch_name
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end
      
    end

    context "_add_generic_associations" do

      it "_add_generic_associations({'param0' => 1, 'param1' => 2})" do
        bind = RbVHDL::Ast.entity_bind_indication('entity_name')
        bind._add_generic_associations({'param0' => 1, 'param1' => 2})
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :entity_name
        expect(bind._architecture_name       ).to eq nil
        expect(bind._generic_association_list.size                                ).to eq 2
        expect(bind._generic_association_list[0].class                            ).to eq RbVHDL::Ast::Association    
        expect(bind._generic_association_list[0]._owner                           ).to eq bind
        expect(bind._generic_association_list[0]._formal_part.class               ).to eq RbVHDL::Ast::Association::FormalName
        expect(bind._generic_association_list[0]._formal_part._name.class         ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._generic_association_list[0]._formal_part._name._name.class   ).to eq RbVHDL::Ast::Identifier
        expect(bind._generic_association_list[0]._formal_part._name._name         ).to eq :param0
        expect(bind._generic_association_list[0]._actual_part.class               ).to eq RbVHDL::Ast::Association::ActualExpression
        expect(bind._generic_association_list[0]._actual_part._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(bind._generic_association_list[0]._actual_part._expression._integer).to eq 1
        expect(bind._generic_association_list[1].class                            ).to eq RbVHDL::Ast::Association    
        expect(bind._generic_association_list[1]._owner                           ).to eq bind
        expect(bind._generic_association_list[1]._formal_part.class               ).to eq RbVHDL::Ast::Association::FormalName
        expect(bind._generic_association_list[1]._formal_part._name.class         ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._generic_association_list[1]._formal_part._name._name.class   ).to eq RbVHDL::Ast::Identifier
        expect(bind._generic_association_list[1]._formal_part._name._name         ).to eq :param1
        expect(bind._generic_association_list[1]._actual_part.class               ).to eq RbVHDL::Ast::Association::ActualExpression
        expect(bind._generic_association_list[1]._actual_part._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(bind._generic_association_list[1]._actual_part._expression._integer).to eq 2
        expect(bind._port_association_list   ).to eq []
      end
    end

    context "_add_port_associations" do

      it "_add_port_associations({'port0' => 'sig0', 'port1' => 'sig1'})" do
        bind = RbVHDL::Ast.entity_bind_indication('entity_name')
        bind._add_port_associations({'port0' => 'sig0', 'port1' => 'sig1'})
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :entity_name
        expect(bind._architecture_name       ).to eq nil
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list.size                             ).to eq 2
        expect(bind._port_association_list[0].class                         ).to eq RbVHDL::Ast::Association    
        expect(bind._port_association_list[0]._owner                        ).to eq bind
        expect(bind._port_association_list[0]._formal_part.class            ).to eq RbVHDL::Ast::Association::FormalName
        expect(bind._port_association_list[0]._formal_part._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._port_association_list[0]._formal_part._name._name.class).to eq RbVHDL::Ast::Identifier
        expect(bind._port_association_list[0]._formal_part._name._name      ).to eq :port0
        expect(bind._port_association_list[0]._actual_part.class            ).to eq RbVHDL::Ast::Association::ActualName
        expect(bind._port_association_list[0]._actual_part._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._port_association_list[0]._actual_part._name._name.class).to eq RbVHDL::Ast::Identifier
        expect(bind._port_association_list[0]._actual_part._name._name      ).to eq :sig0
        expect(bind._port_association_list[1].class                         ).to eq RbVHDL::Ast::Association    
        expect(bind._port_association_list[1]._owner                        ).to eq bind
        expect(bind._port_association_list[1]._formal_part.class            ).to eq RbVHDL::Ast::Association::FormalName
        expect(bind._port_association_list[1]._formal_part._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._port_association_list[1]._formal_part._name._name.class).to eq RbVHDL::Ast::Identifier
        expect(bind._port_association_list[1]._formal_part._name._name      ).to eq :port1
        expect(bind._port_association_list[1]._actual_part.class            ).to eq RbVHDL::Ast::Association::ActualName
        expect(bind._port_association_list[1]._actual_part._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._port_association_list[1]._actual_part._name._name.class).to eq RbVHDL::Ast::Identifier
        expect(bind._port_association_list[1]._actual_part._name._name      ).to eq :sig1
      end

      it "_add_port_associations(['sig0', 'sig1'])" do
        bind = RbVHDL::Ast.entity_bind_indication('entity_name')
        bind._add_port_associations(['sig0', 'sig1'])
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :entity_name
        expect(bind._architecture_name       ).to eq nil
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list.size                             ).to eq 2
        expect(bind._port_association_list[0].class                         ).to eq RbVHDL::Ast::Association    
        expect(bind._port_association_list[0]._owner                        ).to eq bind
        expect(bind._port_association_list[0]._formal_part.class            ).to eq RbVHDL::Ast::Association::FormalIndex
        expect(bind._port_association_list[0]._formal_part._index           ).to eq 0
        expect(bind._port_association_list[0]._actual_part.class            ).to eq RbVHDL::Ast::Association::ActualName
        expect(bind._port_association_list[0]._actual_part._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._port_association_list[0]._actual_part._name._name.class).to eq RbVHDL::Ast::Identifier
        expect(bind._port_association_list[0]._actual_part._name._name      ).to eq :sig0
        expect(bind._port_association_list[1].class                         ).to eq RbVHDL::Ast::Association    
        expect(bind._port_association_list[1]._owner                        ).to eq bind
        expect(bind._port_association_list[1]._formal_part.class            ).to eq RbVHDL::Ast::Association::FormalIndex
        expect(bind._port_association_list[1]._formal_part._index           ).to eq 1
        expect(bind._port_association_list[1]._actual_part.class            ).to eq RbVHDL::Ast::Association::ActualName
        expect(bind._port_association_list[1]._actual_part._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(bind._port_association_list[1]._actual_part._name._name.class).to eq RbVHDL::Ast::Identifier
        expect(bind._port_association_list[1]._actual_part._name._name      ).to eq :sig1
      end
    end
    
  end

  describe 'ConfigurationBindIndication' do
    context "new" do

      it "new(identifier('config_name'))" do
        bind = RbVHDL::Ast::Declaration::ConfigurationBindIndication.new(RbVHDL::Ast.identifier('config_name'))
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::ConfigurationBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :config_name
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end

      it "RbVHDL::Ast.configuration_bind_indication('config_name')" do
        bind = RbVHDL::Ast.configuration_bind_indication('config_name')
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::ConfigurationBindIndication
        expect(bind._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(bind._name                    ).to eq :config_name
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end
      
    end
  end
  
  describe 'OpenBindIndication' do
    context "new" do

      it "new" do
        bind = RbVHDL::Ast::Declaration::OpenBindIndication.new
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::OpenBindIndication
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end

      it "RbVHDL::Ast.open_bind_indication" do
        bind = RbVHDL::Ast.open_bind_indication
        expect(bind.class                    ).to eq RbVHDL::Ast::Declaration::OpenBindIndication
        expect(bind._generic_association_list).to eq []
        expect(bind._port_association_list   ).to eq []
      end

    end
  end

  describe 'BlockConfiguration' do

    context "new" do

      it "new(identifier('label'))" do
        config = RbVHDL::Ast::Declaration::BlockConfiguration.new(RbVHDL::Ast.identifier('label'))
        expect(config.class                 ).to eq RbVHDL::Ast::Declaration::BlockConfiguration
        expect(config._label.class          ).to eq RbVHDL::Ast::Identifier
        expect(config._label                ).to eq :label
        expect(config._declarative_item_list).to eq []
        expect(config._configuration_list   ).to eq []
      end

      it "RbVHDL::Ast.block_configuration('label')" do
        config = RbVHDL::Ast.block_configuration('label')
        expect(config.class                 ).to eq RbVHDL::Ast::Declaration::BlockConfiguration
        expect(config._label.class          ).to eq RbVHDL::Ast::Identifier
        expect(config._label                ).to eq :label
        expect(config._declarative_item_list).to eq []
        expect(config._configuration_list   ).to eq []
      end
      
    end

    context "_block_configuration" do

      it "_block_configuration('sub')" do
        top = RbVHDL::Ast.block_configuration('top')
        sub = top._block_configuration('sub')
        expect(top.class                 ).to eq RbVHDL::Ast::Declaration::BlockConfiguration
        expect(top._label.class          ).to eq RbVHDL::Ast::Identifier
        expect(top._label                ).to eq :top
        expect(top._declarative_item_list).to eq []
        expect(top._configuration_list   ).to eq [sub]
        expect(sub.class                 ).to eq RbVHDL::Ast::Declaration::BlockConfiguration
        expect(sub._label.class          ).to eq RbVHDL::Ast::Identifier
        expect(sub._label                ).to eq :sub
        expect(sub._declarative_item_list).to eq []
        expect(sub._configuration_list   ).to eq []
      end
      
    end

    context "_component_configuration" do

      it "_component_configuration(component_specification('sub'))" do
        top = RbVHDL::Ast.block_configuration('top')
        sub = top._component_configuration(RbVHDL::Ast.component_specification('sub'))
        expect(top.class                      ).to eq RbVHDL::Ast::Declaration::BlockConfiguration
        expect(top._label.class               ).to eq RbVHDL::Ast::Identifier
        expect(top._label                     ).to eq :top
        expect(top._declarative_item_list     ).to eq []
        expect(top._configuration_list        ).to eq [sub]
        expect(sub.class                      ).to eq RbVHDL::Ast::Declaration::ComponentConfiguration
        expect(sub._component_spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(sub._component_spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(sub._component_spec._name      ).to eq :sub
        expect(sub._component_spec._label_list).to eq []
        expect(sub._bind_indication           ).to eq nil
        expect(sub._block_configuration       ).to eq nil
      end
    end

  end

  describe 'ComponentConfiguration' do

    context "new" do

      it "new(component_specification('spec'))" do
        config = RbVHDL::Ast::Declaration::ComponentConfiguration.new(RbVHDL::Ast.component_specification('spec'))
        expect(config.class                      ).to eq RbVHDL::Ast::Declaration::ComponentConfiguration
        expect(config._component_spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(config._component_spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(config._component_spec._name      ).to eq :spec
        expect(config._component_spec._label_list).to eq []
        expect(config._bind_indication           ).to eq nil
        expect(config._block_configuration       ).to eq nil
      end

      it "RbVHDL::Ast.component_configuration(component_specification('spec'))" do
        config = RbVHDL::Ast.component_configuration(RbVHDL::Ast.component_specification('spec'))
        expect(config.class                      ).to eq RbVHDL::Ast::Declaration::ComponentConfiguration
        expect(config._component_spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(config._component_spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(config._component_spec._name      ).to eq :spec
        expect(config._component_spec._label_list).to eq []
        expect(config._bind_indication           ).to eq nil
        expect(config._block_configuration       ).to eq nil
      end

    end
    
    context "_bind_indication" do

      it "_bind_indication = entity_bind_indication('entity_name')" do
        config = RbVHDL::Ast.component_configuration(RbVHDL::Ast.component_specification('spec'))
        config._bind_indication = RbVHDL::Ast.entity_bind_indication('entity_name')
        expect(config.class                                     ).to eq RbVHDL::Ast::Declaration::ComponentConfiguration
        expect(config._component_spec.class                     ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(config._component_spec._name.class               ).to eq RbVHDL::Ast::Identifier
        expect(config._component_spec._name                     ).to eq :spec
        expect(config._component_spec._label_list               ).to eq []
        expect(config._block_configuration                      ).to eq nil
        expect(config._bind_indication.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(config._bind_indication._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(config._bind_indication._name                    ).to eq :entity_name
        expect(config._bind_indication._architecture_name       ).to eq nil
        expect(config._bind_indication._generic_association_list).to eq []
        expect(config._bind_indication._port_association_list   ).to eq []
      end
    end

    context "_block_configuration" do

      it "_block_configuration = block_configuration('label')" do
        config = RbVHDL::Ast.component_configuration(RbVHDL::Ast.component_specification('spec'))
        config._block_configuration = RbVHDL::Ast.block_configuration('label')
        expect(config.class                                      ).to eq RbVHDL::Ast::Declaration::ComponentConfiguration
        expect(config._component_spec.class                      ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(config._component_spec._name.class                ).to eq RbVHDL::Ast::Identifier
        expect(config._component_spec._name                      ).to eq :spec
        expect(config._component_spec._label_list                ).to eq []
        expect(config._bind_indication                           ).to eq nil
        expect(config._block_configuration.class                 ).to eq RbVHDL::Ast::Declaration::BlockConfiguration
        expect(config._block_configuration._label.class          ).to eq RbVHDL::Ast::Identifier
        expect(config._block_configuration._label                ).to eq :label
        expect(config._block_configuration._declarative_item_list).to eq []
        expect(config._block_configuration._configuration_list   ).to eq []
        
      end
    end

  end

  describe 'ConfigurationSpec' do

    context "new" do

      it "new(component_specification('spec'))" do
        spec = RbVHDL::Ast::Declaration::ConfigurationSpec.new(RbVHDL::Ast.component_specification('spec'))
        expect(spec.class                      ).to eq RbVHDL::Ast::Declaration::ConfigurationSpec
        expect(spec._component_spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._component_spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(spec._component_spec._name      ).to eq :spec
        expect(spec._component_spec._label_list).to eq []
        expect(spec._bind_indication           ).to eq nil
      end

      it "RbVHDL::Ast.configuration_specification(component_specification('spec'))" do
        spec = RbVHDL::Ast.configuration_specification(RbVHDL::Ast.component_specification('spec'))
        expect(spec.class                      ).to eq RbVHDL::Ast::Declaration::ConfigurationSpec
        expect(spec._component_spec.class      ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._component_spec._name.class).to eq RbVHDL::Ast::Identifier
        expect(spec._component_spec._name      ).to eq :spec
        expect(spec._component_spec._label_list).to eq []
        expect(spec._bind_indication           ).to eq nil
      end

    end

    context "_bind_indication" do

      it "_bind_indication = entity_bind_indication('entity_name')" do
        spec = RbVHDL::Ast.configuration_specification(RbVHDL::Ast.component_specification('spec'))
        spec._bind_indication = RbVHDL::Ast.entity_bind_indication('entity_name')
        expect(spec.class                                     ).to eq RbVHDL::Ast::Declaration::ConfigurationSpec
        expect(spec._component_spec.class                     ).to eq RbVHDL::Ast::Declaration::ComponentSpecLabels
        expect(spec._component_spec._name.class               ).to eq RbVHDL::Ast::Identifier
        expect(spec._component_spec._name                     ).to eq :spec
        expect(spec._component_spec._label_list               ).to eq []
        expect(spec._bind_indication.class                    ).to eq RbVHDL::Ast::Declaration::EntityBindIndication
        expect(spec._bind_indication._name.class              ).to eq RbVHDL::Ast::Identifier
        expect(spec._bind_indication._name                    ).to eq :entity_name
        expect(spec._bind_indication._architecture_name       ).to eq nil
        expect(spec._bind_indication._generic_association_list).to eq []
        expect(spec._bind_indication._port_association_list   ).to eq []
      end
    end
  end

  describe 'Configuration' do

    context "new" do

      it "new(nil, identifier('config_name'), identifier('entity_name'))" do
        config = RbVHDL::Ast::Declaration::Configuration.new(nil, RbVHDL::Ast.identifier('config_name'), RbVHDL::Ast.identifier('entity_name'))
        expect(config.class                 ).to eq RbVHDL::Ast::Declaration::Configuration
        expect(config._identifier.class     ).to eq RbVHDL::Ast::Identifier
        expect(config._identifier           ).to eq :config_name
        expect(config._entity_name.class    ).to eq RbVHDL::Ast::Identifier
        expect(config._entity_name          ).to eq :entity_name
        expect(config._declarative_item_list).to eq []
        expect(config._block_configuration  ).to eq nil
      end

      it "RbVHDL::Ast.configuration_declaration(nil, 'config_name', 'entity_name')" do
        config = RbVHDL::Ast.configuration_declaration(nil, 'config_name', 'entity_name')
        expect(config.class                 ).to eq RbVHDL::Ast::Declaration::Configuration
        expect(config._identifier.class     ).to eq RbVHDL::Ast::Identifier
        expect(config._identifier           ).to eq :config_name
        expect(config._entity_name.class    ).to eq RbVHDL::Ast::Identifier
        expect(config._entity_name          ).to eq :entity_name
        expect(config._declarative_item_list).to eq []
        expect(config._block_configuration  ).to eq nil
      end

    end

    context "_block_configuration" do

      it "_block_configuration = block_configuration('label')" do
        config = RbVHDL::Ast.configuration_declaration(nil, 'config_name', 'entity_name')
        config._block_configuration = RbVHDL::Ast.block_configuration('label')
        expect(config.class                                      ).to eq RbVHDL::Ast::Declaration::Configuration
        expect(config._identifier.class                          ).to eq RbVHDL::Ast::Identifier
        expect(config._identifier                                ).to eq :config_name
        expect(config._entity_name.class                         ).to eq RbVHDL::Ast::Identifier
        expect(config._entity_name                               ).to eq :entity_name
        expect(config._declarative_item_list                     ).to eq []
        expect(config._block_configuration.class                 ).to eq RbVHDL::Ast::Declaration::BlockConfiguration
        expect(config._block_configuration._label.class          ).to eq RbVHDL::Ast::Identifier
        expect(config._block_configuration._label                ).to eq :label
        expect(config._block_configuration._declarative_item_list).to eq []
        expect(config._block_configuration._configuration_list   ).to eq []
        
      end
    end
  end

end
