require "spec_helper"

describe 'RbVHDL::Ast::Expression::Aggregate' do

  context "_write_string" do
    it do
      string = RbVHDL::Ast.aggregate._write_string({})
      expect(string).to eq "()"
    end
    it do
      string = RbVHDL::Ast.aggregate(RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice_others, 1))._write_string({})
      expect(string).to eq "(others => 1)"
    end
    it do
      aggregate = RbVHDL::Ast.aggregate([ RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice(0)    , 1),
                                          RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice_others, 0)
                                        ])
      string = aggregate._write_string({})
      expect(string).to eq "(0 => 1, others => 0)"
    end
  end
end

