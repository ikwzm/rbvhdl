require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Entity' do

  entity = RbVHDL::Ast.entity_declaration(nil, 'sample')

  it "new('sample')" do
    expect(entity._owner           ).to eq nil
    expect(entity.class            ).to eq RbVHDL::Ast::Declaration::Entity
    expect(entity._identifier.class).to eq RbVHDL::Ast::Identifier
    expect(entity._identifier      ).to eq :sample
  end

  it "generic_interface('width', 'integer', decimal_literal(5))" do
    entity._generic_interface('width', 'integer', RbVHDL::Ast.decimal_literal(5))
    expect(entity._generic_interface_list.size                                   ).to eq 1
    expect(entity._generic_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface::Constant
    expect(entity._generic_interface_list[0]._identifier_list.size               ).to eq 1
    expect(entity._generic_interface_list[0]._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
    expect(entity._generic_interface_list[0]._identifier_list[0]                 ).to eq :width
    expect(entity._generic_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(entity._generic_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
    expect(entity._generic_interface_list[0]._subtype_indication._type_mark      ).to eq :integer
    expect(entity._generic_interface_list[0]._mode                               ).to eq nil
    expect(entity._generic_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(entity._generic_interface_list[0]._static_expression._integer         ).to eq 5
  end

end

