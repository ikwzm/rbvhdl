require "spec_helper"

describe 'RbVHDL::Ast::DesignUnit' do

  context "_library_clause" do

    it "_library_clause('ieee')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _library_clause('ieee')
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::LibraryClause
      expect(design_unit._unit_list[0]._identifier_list.size              ).to eq 1
      expect(design_unit._unit_list[0]._identifier_list[0].class          ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier_list[0]                ).to eq :ieee
    end
  end

  context "_use_clause" do

    it "_use_clause(name(:ieee)._select(:numeric_std)._select(:ALL))" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _use_clause(RbVHDL::Ast.name(:ieee)._select(:numeric_std)._select(:ALL))
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::UseClause
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._name_list.size                    ).to eq 1
      expect(design_unit._unit_list[0]._name_list[0].class                ).to eq RbVHDL::Ast::Expression::SelectedName
      expect(design_unit._unit_list[0]._name_list[0]._prefix.class        ).to eq RbVHDL::Ast::Expression::SelectedName
      expect(design_unit._unit_list[0]._name_list[0]._prefix._prefix.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._name_list[0]._prefix._prefix._name).to eq :ieee
      expect(design_unit._unit_list[0]._name_list[0]._prefix._suffix.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._name_list[0]._prefix._suffix._name).to eq :numeric_std
      expect(design_unit._unit_list[0]._name_list[0]._suffix.class        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._name_list[0]._suffix._name        ).to eq :ALL
    end

    it "_use_clause()._use!(name(:work)._select(:textio)._select(:ALL))" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _use_clause._use!(RbVHDL::Ast.name(:work)._select(:textio)._select(:ALL))
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::UseClause
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._name_list.size                    ).to eq 1
      expect(design_unit._unit_list[0]._name_list[0].class                ).to eq RbVHDL::Ast::Expression::SelectedName
      expect(design_unit._unit_list[0]._name_list[0]._prefix.class        ).to eq RbVHDL::Ast::Expression::SelectedName
      expect(design_unit._unit_list[0]._name_list[0]._prefix._prefix.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._name_list[0]._prefix._prefix._name).to eq :work
      expect(design_unit._unit_list[0]._name_list[0]._prefix._suffix.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._name_list[0]._prefix._suffix._name).to eq :textio
      expect(design_unit._unit_list[0]._name_list[0]._suffix.class        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._name_list[0]._suffix._name        ).to eq :ALL
    end
  end

  context "_entity" do

    it "_entity('sample')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _entity('sample')
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::Entity
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :sample
      expect(design_unit._unit_list[0]._generic_interface_list            ).to eq []
      expect(design_unit._unit_list[0]._port_interface_list               ).to eq []
      expect(design_unit._unit_list[0]._declarative_item_list             ).to eq []
      expect(design_unit._unit_list[0]._statement_list                    ).to eq []
    end

    it "_entity('sample'){...}" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _entity('sample') {
          _port_interface('I', RbVHDL::Ast.subtype_indication('std_logic'), :in )
          _port_interface('O', RbVHDL::Ast.subtype_indication('std_logic'), :out)
        }
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::Entity
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :sample
      expect(design_unit._unit_list[0]._generic_interface_list            ).to eq []
      expect(design_unit._unit_list[0]._port_interface_list.size          ).to eq 2
      expect(design_unit._unit_list[0]._port_interface_list[0].class      ).to eq RbVHDL::Ast::Interface
      expect(design_unit._unit_list[0]._port_interface_list[0]._owner     ).to eq design_unit._unit_list[0]
      expect(design_unit._unit_list[0]._port_interface_list[1].class      ).to eq RbVHDL::Ast::Interface
      expect(design_unit._unit_list[0]._port_interface_list[1]._owner     ).to eq design_unit._unit_list[0]
      expect(design_unit._unit_list[0]._declarative_item_list             ).to eq []
      expect(design_unit._unit_list[0]._declarative_item_list             ).to eq []
      expect(design_unit._unit_list[0]._statement_list                    ).to eq []
    end
  end

  context "_architecture" do

    it "_architecture('model', 'sample')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('model', 'sample')
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :model
      expect(design_unit._unit_list[0]._entity_name.class                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._entity_name._name.class           ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._entity_name._name                 ).to eq :sample
      expect(design_unit._unit_list[0]._declarative_item_list             ).to eq []
      expect(design_unit._unit_list[0]._statement_list                    ).to eq []
    end

    it "_architecture('model', 'sample'){...}" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('model', 'sample') {
          _signal_declaration('sig0', RbVHDL::Ast.subtype_indication('std_logic'))
        }
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :model
      expect(design_unit._unit_list[0]._entity_name.class                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._entity_name._name.class           ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._entity_name._name                 ).to eq :sample
      expect(design_unit._unit_list[0]._declarative_item_list.size        ).to eq 1
      expect(design_unit._unit_list[0]._declarative_item_list[0].class    ).to eq RbVHDL::Ast::Declaration::Signal
      expect(design_unit._unit_list[0]._declarative_item_list[0]._owner   ).to eq design_unit._unit_list[0]
      expect(design_unit._unit_list[0]._statement_list                    ).to eq []
    end
  end

  context "_package" do

    it "_package('sample_package')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _package('sample_package')
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::Package
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :sample_package
      expect(design_unit._unit_list[0]._generic_interface_list            ).to eq []
      expect(design_unit._unit_list[0]._generic_association_list          ).to eq []
      expect(design_unit._unit_list[0]._declarative_item_list             ).to eq []
    end

    it "_package('sample_package'){...}" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _package('sample_package'){
          _enumeration_type_declaration('STATE_TYPE', ['IDLE_STATE', 'RUN_STATE', 'DONE_STATE'])
        }
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::Package
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :sample_package
      expect(design_unit._unit_list[0]._generic_interface_list            ).to eq []
      expect(design_unit._unit_list[0]._generic_association_list          ).to eq []
      expect(design_unit._unit_list[0]._declarative_item_list.size        ).to eq 1
      expect(design_unit._unit_list[0]._declarative_item_list[0].class    ).to eq RbVHDL::Ast::Declaration::EnumerationType
      expect(design_unit._unit_list[0]._declarative_item_list[0]._owner   ).to eq design_unit._unit_list[0]
    end
  end

  context "_package_body" do

    it "_package_body('sample_package')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _package_body('sample_package')
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::PackageBody
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :sample_package
      expect(design_unit._unit_list[0]._declarative_item_list             ).to eq []
    end

    it "_package_body('sample_package'){...}" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _package_body('sample_package'){
          _enumeration_type_declaration('STATE_TYPE', ['IDLE_STATE', 'RUN_STATE', 'DONE_STATE'])
        }
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::PackageBody
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :sample_package
      expect(design_unit._unit_list[0]._declarative_item_list.size        ).to eq 1
      expect(design_unit._unit_list[0]._declarative_item_list[0].class    ).to eq RbVHDL::Ast::Declaration::EnumerationType
      expect(design_unit._unit_list[0]._declarative_item_list[0]._owner   ).to eq design_unit._unit_list[0]
    end
  end

  context "_configuration" do

    it "_configuration('sample_config', 'sample')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _configuration('sample_config', 'sample')
      }
      expect(design_unit._unit_list.size                                  ).to eq 1
      expect(design_unit._unit_list[0].class                              ).to eq RbVHDL::Ast::Declaration::Configuration
      expect(design_unit._unit_list[0]._owner                             ).to eq design_unit
      expect(design_unit._unit_list[0]._identifier.class                  ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._identifier                        ).to eq :sample_config
      expect(design_unit._unit_list[0]._entity_name.class                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(design_unit._unit_list[0]._entity_name._name.class           ).to eq RbVHDL::Ast::Identifier
      expect(design_unit._unit_list[0]._entity_name._name                 ).to eq :sample
      expect(design_unit._unit_list[0]._declarative_item_list             ).to eq []
      expect(design_unit._unit_list[0]._block_configuration               ).to eq nil
    end
  end
end
  
