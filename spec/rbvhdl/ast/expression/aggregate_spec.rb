require "spec_helper"

describe 'RbVHDL::Ast::Expression::Aggregate' do

  context "new" do

    it "new([])" do
      aggregate = RbVHDL::Ast::Expression::Aggregate.new([])
      expect(aggregate.class     ).to eq RbVHDL::Ast::Expression::Aggregate
      expect(aggregate._item_list).to eq []
    end

    it "new([aggregate_item(nil, 0)])" do
      aggregate = RbVHDL::Ast::Expression::Aggregate.new([RbVHDL::Ast.aggregate_item(nil, 0)])
      expect(aggregate.class                             ).to eq RbVHDL::Ast::Expression::Aggregate
      expect(aggregate._item_list.size                   ).to eq 1
      expect(aggregate._item_list[0].class               ).to eq RbVHDL::Ast::Expression::Aggregate::Item
      expect(aggregate._item_list[0]._choices            ).to eq nil
      expect(aggregate._item_list[0]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[0]._expression._integer).to eq 0
    end

    it "new([aggregate_item(choice_others, 1)])" do
      aggregate = RbVHDL::Ast::Expression::Aggregate.new([RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice_others, 1)])
      expect(aggregate.class                             ).to eq RbVHDL::Ast::Expression::Aggregate
      expect(aggregate._item_list.size                   ).to eq 1
      expect(aggregate._item_list[0].class               ).to eq RbVHDL::Ast::Expression::Aggregate::Item
      expect(aggregate._item_list[0]._choices.class      ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      expect(aggregate._item_list[0]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[0]._expression._integer).to eq 1
    end

    it "RbVHDL::Ast.aggregate" do
      aggregate = RbVHDL::Ast.aggregate
      expect(aggregate.class     ).to eq RbVHDL::Ast::Expression::Aggregate
      expect(aggregate._item_list).to eq []
    end

    it "RbVHDL::Ast.aggregate(aggregate_item(choice_others, 1))" do
      aggregate = RbVHDL::Ast.aggregate(RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice_others, 1))
      expect(aggregate.class     ).to eq RbVHDL::Ast::Expression::Aggregate
      expect(aggregate._item_list.size                   ).to eq 1
      expect(aggregate._item_list[0].class               ).to eq RbVHDL::Ast::Expression::Aggregate::Item
      expect(aggregate._item_list[0]._choices.class      ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      expect(aggregate._item_list[0]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[0]._expression._integer).to eq 1
    end

    it "RbVHDL::Ast.aggregate([aggregate_item(choice(0),1),aggregate_item(choice_others,0)])" do
      aggregate = RbVHDL::Ast.aggregate([ RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice(0)    , 1),
                                          RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice_others, 0)
                                        ])
      expect(aggregate.class     ).to eq RbVHDL::Ast::Expression::Aggregate
      expect(aggregate._item_list.size                            ).to eq 2
      expect(aggregate._item_list[0].class                        ).to eq RbVHDL::Ast::Expression::Aggregate::Item
      expect(aggregate._item_list[0]._choices.class               ).to eq RbVHDL::Ast::Expression::ChoiceExpression
      expect(aggregate._item_list[0]._choices._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[0]._choices._expression._integer).to eq 0
      expect(aggregate._item_list[0]._expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[0]._expression._integer         ).to eq 1
      expect(aggregate._item_list[1].class                        ).to eq RbVHDL::Ast::Expression::Aggregate::Item
      expect(aggregate._item_list[1]._choices.class               ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      expect(aggregate._item_list[1]._expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[1]._expression._integer         ).to eq 0
    end

  end

  context "_add_item!" do

    aggregate = RbVHDL::Ast::Expression::Aggregate.new([])._add_item!(RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice(0), 1))

    it "_add_item!(aggregate_item(choice(0), 1))" do
      expect(aggregate.class     ).to eq RbVHDL::Ast::Expression::Aggregate
      expect(aggregate._item_list.size                            ).to eq 1
      expect(aggregate._item_list[0].class                        ).to eq RbVHDL::Ast::Expression::Aggregate::Item
      expect(aggregate._item_list[0]._choices.class               ).to eq RbVHDL::Ast::Expression::ChoiceExpression
      expect(aggregate._item_list[0]._choices._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[0]._choices._expression._integer).to eq 0
      expect(aggregate._item_list[0]._expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[0]._expression._integer         ).to eq 1
    end

    it "_add_item!(aggregate_item(choice_others, 0))" do
      aggregate._add_item!(RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice_others, 0))
      expect(aggregate._item_list.size                            ).to eq 2
      expect(aggregate._item_list[1].class                        ).to eq RbVHDL::Ast::Expression::Aggregate::Item
      expect(aggregate._item_list[1]._choices.class               ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      expect(aggregate._item_list[1]._expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(aggregate._item_list[1]._expression._integer         ).to eq 0
    end
  end
end
