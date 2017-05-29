require "spec_helper"

describe 'RbVHDL::Ast::Type::Range' do

  it "range_attr('singal_type', 'range')" do
    range = RbVHDL::Ast.range_attr(RbVHDL::Ast.name('signal_type')._attribute('range'))
    expect(range.class                  ).to eq RbVHDL::Ast::Type::RangeAttribute
    expect(range._name.class            ).to eq RbVHDL::Ast::Expression::AttributeName
    expect(range._name._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
    expect(range._name._name._name      ).to eq :signal_type
    expect(range._name._attribute.class ).to eq RbVHDL::Ast::Identifier
    expect(range._name._attribute       ).to eq :range
  end

  it "range_to(0, 2)" do
    range = RbVHDL::Ast.range_to(0, 2)
    expect(range.class                  ).to eq RbVHDL::Ast::Type::RangeTo
    expect(range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._l_expr._integer       ).to eq 0
    expect(range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._r_expr._integer       ).to eq 2
  end
  
  it "range_downto(7, 3)" do
    range = RbVHDL::Ast.range_downto(7, 3)
    expect(range.class                  ).to eq RbVHDL::Ast::Type::RangeDownto
    expect(range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._l_expr._integer       ).to eq 7
    expect(range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._r_expr._integer       ).to eq 3
  end

  it "range_to(decimal_literal(0), decimal_literal(2))" do
    range = RbVHDL::Ast.range_to(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(2))
    expect(range.class                  ).to eq RbVHDL::Ast::Type::RangeTo
    expect(range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._l_expr._integer       ).to eq 0
    expect(range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._r_expr._integer       ).to eq 2
  end
  
  it "range_downto(decimal_literal(7), decimal_literal(3))" do
    range = RbVHDL::Ast.range_downto(RbVHDL::Ast.decimal_literal(7),RbVHDL::Ast.decimal_literal(3))
    expect(range.class                  ).to eq RbVHDL::Ast::Type::RangeDownto
    expect(range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._l_expr._integer       ).to eq 7
    expect(range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
    expect(range._r_expr._integer       ).to eq 3
  end
end  

