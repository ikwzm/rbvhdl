require "spec_helper"

describe 'RbVHDL::Ast::DesignUnit' do
  
  design_unit = RbVHDL::Ast::DesignUnit.new

  it "library ieee;" do
    design_unit._library_clause('ieee')
    expect(design_unit._unit_list.size                        ).to eq 1
    expect(design_unit._unit_list[0].class                    ).to eq RbVHDL::Ast::LibraryClause
    expect(design_unit._unit_list[0]._identifier_list.size    ).to eq 1
    expect(design_unit._unit_list[0]._identifier_list[0].class).to eq RbVHDL::Ast::Identifier
    expect(design_unit._unit_list[0]._identifier_list[0]      ).to eq :ieee
  end

  it "design_unit._use_clause(name(:ieee)._select(:numeric_std)._select(:ALL))" do
    design_unit._use_clause(RbVHDL::Ast.name(:ieee)._select(:numeric_std)._select(:ALL))
    expect(design_unit._unit_list.size                                  ).to eq 2
    expect(design_unit._unit_list[1].class                              ).to eq RbVHDL::Ast::Declaration::UseClause
    expect(design_unit._unit_list[1]._owner                             ).to eq design_unit
    expect(design_unit._unit_list[1]._name_list.size                    ).to eq 1
    expect(design_unit._unit_list[1]._name_list[0].class                ).to eq RbVHDL::Ast::Expression::SelectedName
    expect(design_unit._unit_list[1]._name_list[0]._prefix.class        ).to eq RbVHDL::Ast::Expression::SelectedName
    expect(design_unit._unit_list[1]._name_list[0]._prefix._prefix.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(design_unit._unit_list[1]._name_list[0]._prefix._prefix._name).to eq :ieee
    expect(design_unit._unit_list[1]._name_list[0]._prefix._suffix.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(design_unit._unit_list[1]._name_list[0]._prefix._suffix._name).to eq :numeric_std
    expect(design_unit._unit_list[1]._name_list[0]._suffix.class        ).to eq RbVHDL::Ast::Expression::SimpleName
    expect(design_unit._unit_list[1]._name_list[0]._suffix._name        ).to eq :ALL
  end

  it "design_unit._use_clause()._use!(name(:work)._select(:textio)._select(:ALL))" do
    design_unit._use_clause._use!(RbVHDL::Ast.name(:work)._select(:textio)._select(:ALL))
    expect(design_unit._unit_list.size                                  ).to eq 3
    expect(design_unit._unit_list[2].class                              ).to eq RbVHDL::Ast::Declaration::UseClause
    expect(design_unit._unit_list[2]._owner                             ).to eq design_unit
    expect(design_unit._unit_list[2]._name_list.size                    ).to eq 1
    expect(design_unit._unit_list[2]._name_list[0].class                ).to eq RbVHDL::Ast::Expression::SelectedName
    expect(design_unit._unit_list[2]._name_list[0]._prefix.class        ).to eq RbVHDL::Ast::Expression::SelectedName
    expect(design_unit._unit_list[2]._name_list[0]._prefix._prefix.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(design_unit._unit_list[2]._name_list[0]._prefix._prefix._name).to eq :work
    expect(design_unit._unit_list[2]._name_list[0]._prefix._suffix.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(design_unit._unit_list[2]._name_list[0]._prefix._suffix._name).to eq :textio
    expect(design_unit._unit_list[2]._name_list[0]._suffix.class        ).to eq RbVHDL::Ast::Expression::SimpleName
    expect(design_unit._unit_list[2]._name_list[0]._suffix._name        ).to eq :ALL
  end

end
  
