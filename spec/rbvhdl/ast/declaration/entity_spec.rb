require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Entity' do


  it "new('sample')" do
    entity = RbVHDL::Ast.entity_declaration(nil, 'sample')
    expect(entity._owner           ).to eq nil
    expect(entity.class            ).to eq RbVHDL::Ast::Declaration::Entity
    expect(entity._identifier.class).to eq RbVHDL::Ast::Identifier
    expect(entity._identifier      ).to eq :sample
  end

  it "generic_interface('width', 'integer', 5)" do
    entity = RbVHDL::Ast.entity_declaration(nil, 'sample')
    entity._generic_interface('width', 'integer', 5)
    expect(entity._generic_interface_list.size                                   ).to eq 1
    expect(entity._generic_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
    expect(entity._generic_interface_list[0]._identifier_list.size               ).to eq 1
    expect(entity._generic_interface_list[0]._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
    expect(entity._generic_interface_list[0]._identifier_list[0]                 ).to eq :width
    expect(entity._generic_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(entity._generic_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(entity._generic_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
    expect(entity._generic_interface_list[0]._mode                               ).to eq nil
    expect(entity._generic_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(entity._generic_interface_list[0]._static_expression._integer         ).to eq 5
  end

  it "port_interface('width', 'integer', 5)" do
    entity = RbVHDL::Ast.entity_declaration(nil, 'sample')
    entity._port_interface('CLK'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
    entity._port_interface('RST'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
    entity._port_interface('D'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(7,0), :in )
    entity._port_interface('Q'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(7,0), :out)
    expect(entity._port_interface_list.size                                   ).to eq 4
    expect(entity._port_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
    expect(entity._port_interface_list[0]._identifier_list.size               ).to eq 1
    expect(entity._port_interface_list[0]._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
    expect(entity._port_interface_list[0]._identifier_list[0]                 ).to eq :CLK
    expect(entity._port_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(entity._port_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(entity._port_interface_list[0]._subtype_indication._type_mark._name).to eq :std_logic
    expect(entity._port_interface_list[0]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::In
    expect(entity._port_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface
    expect(entity._port_interface_list[1]._identifier_list.size               ).to eq 1
    expect(entity._port_interface_list[1]._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
    expect(entity._port_interface_list[1]._identifier_list[0]                 ).to eq :RST
    expect(entity._port_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(entity._port_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(entity._port_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic
    expect(entity._port_interface_list[1]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::In
    expect(entity._port_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface
    expect(entity._port_interface_list[2]._identifier_list.size               ).to eq 1
    expect(entity._port_interface_list[2]._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
    expect(entity._port_interface_list[2]._identifier_list[0]                 ).to eq :D
    expect(entity._port_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(entity._port_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(entity._port_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
    expect(entity._port_interface_list[2]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::In
    expect(entity._port_interface_list[3].class                               ).to eq RbVHDL::Ast::Interface
    expect(entity._port_interface_list[3]._identifier_list.size               ).to eq 1
    expect(entity._port_interface_list[3]._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
    expect(entity._port_interface_list[3]._identifier_list[0]                 ).to eq :Q
    expect(entity._port_interface_list[3]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(entity._port_interface_list[3]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(entity._port_interface_list[3]._subtype_indication._type_mark._name).to eq :std_logic_vector
    expect(entity._port_interface_list[3]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::Out
  end
end

