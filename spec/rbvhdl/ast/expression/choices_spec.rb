require "spec_helper"

describe 'RbVHDL::Ast::Expression::Choice' do

  describe 'ChoiceExpression' do
    context "new" do

      it "new(name('sig1')._attribute('range'))" do
        choice = RbVHDL::Ast::Expression::ChoiceExpression.new(RbVHDL::Ast.expression(RbVHDL::Ast.name('sig1')._attribute('range')))
        expect(choice.class                  ).to eq RbVHDL::Ast::Expression::ChoiceExpression
        expect(choice._expression.class      ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(choice._expression._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(choice._expression._name._name).to eq :sig1
        expect(choice._expression._attribute ).to eq :range
      end

      it "RbVHDL::Ast.choice_expression(name('sig1')._attribute('range'))" do
        choice = RbVHDL::Ast.choice_expression(RbVHDL::Ast.expression(RbVHDL::Ast.name('sig1')._attribute('range')))
        expect(choice.class                  ).to eq RbVHDL::Ast::Expression::ChoiceExpression
        expect(choice._expression.class      ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(choice._expression._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(choice._expression._name._name).to eq :sig1
        expect(choice._expression._attribute ).to eq :range
      end

    end
  end
  
  describe 'ChoiceRange' do
    context "new" do

      it "new(range_to(0, 2))" do
        choice = RbVHDL::Ast::Expression::ChoiceRange.new(RbVHDL::Ast.range_to(0, 2))
        expect(choice.class                        ).to eq RbVHDL::Ast::Expression::ChoiceRange
        expect(choice._range.class                 ).to eq RbVHDL::Ast::Type::RangeTo
        expect(choice._range._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choice._range._l_expr._integer      ).to eq 0
        expect(choice._range._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choice._range._r_expr._integer      ).to eq 2
      end

      it "RbVHDL::Ast.choice_range_attr(name('signal_type')._attribute('range'))" do
        choice = RbVHDL::Ast.choice_range_attr(RbVHDL::Ast.name('signal_type')._attribute('range'))
        expect(choice.class                        ).to eq RbVHDL::Ast::Expression::ChoiceRange
        expect(choice._range.class                 ).to eq RbVHDL::Ast::Type::RangeAttribute
        expect(choice._range._name.class           ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(choice._range._name._name.class     ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(choice._range._name._name._name     ).to eq :signal_type
        expect(choice._range._name._attribute.class).to eq RbVHDL::Ast::Identifier
        expect(choice._range._name._attribute      ).to eq :range
      end

      it "RbVHDL::Ast.choice_range_to(0, 2)" do
        choice = RbVHDL::Ast.choice_range_to(0, 2)
        expect(choice.class                        ).to eq RbVHDL::Ast::Expression::ChoiceRange
        expect(choice._range.class                 ).to eq RbVHDL::Ast::Type::RangeTo
        expect(choice._range._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choice._range._l_expr._integer      ).to eq 0
        expect(choice._range._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choice._range._r_expr._integer      ).to eq 2
      end

      it "RbVHDL::Ast.choice_range_downto(7, 0)" do
        choice = RbVHDL::Ast.choice_range_downto(7, 0)
        expect(choice.class                        ).to eq RbVHDL::Ast::Expression::ChoiceRange
        expect(choice._range.class                 ).to eq RbVHDL::Ast::Type::RangeDownto
        expect(choice._range._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choice._range._l_expr._integer      ).to eq 7
        expect(choice._range._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choice._range._r_expr._integer      ).to eq 0
      end

    end
  end

  describe 'ChoiceIdentifier' do
    context "new" do

      it "new(identifier('sig1'))" do
        choice = RbVHDL::Ast::Expression::ChoiceIdentifier.new(RbVHDL::Ast.identifier('sig1'))
        expect(choice.class      ).to eq RbVHDL::Ast::Expression::ChoiceIdentifier
        expect(choice._name.class).to eq RbVHDL::Ast::Identifier
        expect(choice._name      ).to eq :sig1
      end

      it "RbVHDL::Ast.choice_identifier('sig1')" do
        choice = RbVHDL::Ast.choice_identifier('sig1')
        expect(choice.class      ).to eq RbVHDL::Ast::Expression::ChoiceIdentifier
        expect(choice._name.class).to eq RbVHDL::Ast::Identifier
        expect(choice._name      ).to eq :sig1
      end

    end
  end

  describe 'ChoiceOthers' do
    context "new" do

      it "new()" do
        choice = RbVHDL::Ast::Expression::ChoiceOthers.new
        expect(choice.class).to eq RbVHDL::Ast::Expression::ChoiceOthers
      end

      it "RbVHDL::Ast.choice_others" do
        choice = RbVHDL::Ast.choice_others
        expect(choice.class).to eq RbVHDL::Ast::Expression::ChoiceOthers
      end

    end
  end
  
  describe 'Choices' do
    context "new" do

      it "RbVHDL::Ast.choices(...)" do
        choice_list = [RbVHDL::Ast.name('sig1')._attribute('range'),
                       RbVHDL::Ast.range_to(0, 3),
                       RbVHDL::Ast.choice_expression(RbVHDL::Ast.name('sig2')._attribute('range')),
                       RbVHDL::Ast.choice_identifier('sig3'),
                       RbVHDL::Ast.choice_range_downto(7, 0),
                       RbVHDL::Ast.choice_others]
        choices = RbVHDL::Ast.choices(choice_list)
        expect(choices.class                                  ).to eq RbVHDL::Ast::Expression::Choices
        expect(choices._choice_list.size                      ).to eq 6
        expect(choices._choice_list[0].class                  ).to eq RbVHDL::Ast::Expression::ChoiceExpression
        expect(choices._choice_list[0]._expression.class      ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(choices._choice_list[0]._expression._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(choices._choice_list[0]._expression._name._name).to eq :sig1
        expect(choices._choice_list[0]._expression._attribute ).to eq :range
        expect(choices._choice_list[1].class                  ).to eq RbVHDL::Ast::Expression::ChoiceRange
        expect(choices._choice_list[1]._range.class           ).to eq RbVHDL::Ast::Type::RangeTo
        expect(choices._choice_list[1]._range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choices._choice_list[1]._range._l_expr._integer).to eq 0
        expect(choices._choice_list[1]._range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choices._choice_list[1]._range._r_expr._integer).to eq 3
        expect(choices._choice_list[2].class                  ).to eq RbVHDL::Ast::Expression::ChoiceExpression
        expect(choices._choice_list[2]._expression.class      ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(choices._choice_list[2]._expression._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(choices._choice_list[2]._expression._name._name).to eq :sig2
        expect(choices._choice_list[2]._expression._attribute ).to eq :range
        expect(choices._choice_list[3].class                  ).to eq RbVHDL::Ast::Expression::ChoiceIdentifier
        expect(choices._choice_list[3]._name.class            ).to eq RbVHDL::Ast::Identifier
        expect(choices._choice_list[3]._name                  ).to eq :sig3
        expect(choices._choice_list[4].class                  ).to eq RbVHDL::Ast::Expression::ChoiceRange
        expect(choices._choice_list[4]._range.class           ).to eq RbVHDL::Ast::Type::RangeDownto
        expect(choices._choice_list[4]._range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choices._choice_list[4]._range._l_expr._integer).to eq 7
        expect(choices._choice_list[4]._range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(choices._choice_list[4]._range._r_expr._integer).to eq 0
        expect(choices._choice_list[5].class                  ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      end

    end
  end
  
end

