require "spec_helper"

describe 'RbVHDL::Ast::Type::Indication' do
  
  it "new(type_mark('unsigned'))" do
    type = RbVHDL::Ast::Type::Indication.new(RbVHDL::Ast.type_mark('unsigned'))
    expect(type.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(type._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(type._type_mark._name).to eq :unsigned
    expect(type._constraint     ).to eq nil
    expect(type._resolution     ).to eq nil
  end

  it "new(type_mark('unsigned')).downto(3, 0)" do
    type = RbVHDL::Ast::Type::Indication.new(RbVHDL::Ast.type_mark('unsigned'))._downto(3, 0)
    expect(type.class                                             ).to eq RbVHDL::Ast::Type::Indication
    expect(type._type_mark.class                                  ).to eq RbVHDL::Ast::Expression::SimpleName
    expect(type._type_mark._name                                  ).to eq :unsigned
    expect(type._constraint.class                                 ).to eq RbVHDL::Ast::Type::Indication::ArrayConstraint
    expect(type._constraint._range_list.size                      ).to eq 1
    expect(type._constraint._range_list[0].class                  ).to eq RbVHDL::Ast::Type::RangeDownto
    expect(type._constraint._range_list[0]._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(type._constraint._range_list[0]._l_expr._integer       ).to eq 3
    expect(type._constraint._range_list[0]._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(type._constraint._range_list[0]._r_expr._integer       ).to eq 0
    expect(type._resolution                                       ).to eq nil
  end
  
  it "new('vec_2d').downto(3, 0).to(0, 3)" do
    type = RbVHDL::Ast::Type::Indication.new(RbVHDL::Ast.type_mark('vec_2d'))._downto(3,0)._to(0,3)
    expect(type.class                                             ).to eq RbVHDL::Ast::Type::Indication
    expect(type._type_mark.class                                  ).to eq RbVHDL::Ast::Expression::SimpleName
    expect(type._type_mark._name                                  ).to eq :vec_2d
    expect(type._constraint.class                                 ).to eq RbVHDL::Ast::Type::Indication::ArrayConstraint
    expect(type._constraint._range_list.size                      ).to eq 2
    expect(type._constraint._range_list[0].class                  ).to eq RbVHDL::Ast::Type::RangeDownto
    expect(type._constraint._range_list[0]._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(type._constraint._range_list[0]._l_expr._integer       ).to eq 3
    expect(type._constraint._range_list[0]._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(type._constraint._range_list[0]._r_expr._integer       ).to eq 0
    expect(type._constraint._range_list[1].class                  ).to eq RbVHDL::Ast::Type::RangeTo
    expect(type._constraint._range_list[1]._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(type._constraint._range_list[1]._l_expr._integer       ).to eq 0
    expect(type._constraint._range_list[1]._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(type._constraint._range_list[1]._r_expr._integer       ).to eq 3
    expect(type._resolution                                       ).to eq nil
  end

  it "RbVHDL::Ast.subtype_indication('string_type')" do
    type = RbVHDL::Ast.subtype_indication('string_type')
    expect(type.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(type._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(type._type_mark._name).to eq :string_type
    expect(type._constraint     ).to eq nil
    expect(type._resolution     ).to eq nil
  end 

  it "RbVHDL::Ast.subtype_indication(:symbol_type)" do
    type = RbVHDL::Ast.subtype_indication(:symbol_type)
    expect(type.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(type._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(type._type_mark._name).to eq :symbol_type
    expect(type._constraint     ).to eq nil
    expect(type._resolution     ).to eq nil
  end 
  
  it "RbVHDL::Ast.subtype_indication(type_mark(:mark_type))" do
    type = RbVHDL::Ast.subtype_indication(RbVHDL::Ast.type_mark(:mark_type))
    expect(type.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(type._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(type._type_mark._name).to eq :mark_type
    expect(type._constraint     ).to eq nil
    expect(type._resolution     ).to eq nil
  end 
  
  it "RbVHDL::Ast.subtype_indication(subtype_indication(type_mark(:mark_type)))" do
    type = RbVHDL::Ast.subtype_indication(RbVHDL::Ast.subtype_indication(RbVHDL::Ast.type_mark(:mark_type)))
    expect(type.class           ).to eq RbVHDL::Ast::Type::Indication
    expect(type._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
    expect(type._type_mark._name).to eq :mark_type
    expect(type._constraint     ).to eq nil
    expect(type._resolution     ).to eq nil
  end 
  
end

