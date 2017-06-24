require "spec_helper"

describe 'RbVHDL::Ast::Statement::IfGenerate' do

  context "new" do

    it "new(nil, label('IF_COND0'), name('cond_0'))" do
      stmt = RbVHDL::Ast::Statement::IfGenerate.new(nil, RbVHDL::Ast.label('IF_COND0'), RbVHDL::Ast.name('cond_0'))
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::IfGenerate
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :IF_COND0
      expect(stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._condition._name       ).to eq :cond_0
      expect(stmt._declarative_item_list ).to eq []
      expect(stmt._statement_list        ).to eq []
    end

  end
end

describe 'RbVHDL::Ast::Statement::ForGenerate' do

  context "new" do

    it "new(nil, label('FOR_GEN'), identifier('i'), range_to(0,7)" do
      stmt = RbVHDL::Ast::Statement::ForGenerate.new(nil, RbVHDL::Ast.label('FOR_GEN'), RbVHDL::Ast.identifier('i'), RbVHDL::Ast.range_to(0, 7))
      expect(stmt.class                        ).to eq RbVHDL::Ast::Statement::ForGenerate
      expect(stmt._owner                       ).to eq nil
      expect(stmt._label.class                 ).to eq RbVHDL::Ast::Label
      expect(stmt._label                       ).to eq :FOR_GEN
      expect(stmt._index_identifier.class      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._index_identifier            ).to eq :i
      expect(stmt._index_range.class           ).to eq RbVHDL::Ast::Type::RangeTo
      expect(stmt._index_range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._index_range._l_expr._integer).to eq 0
      expect(stmt._index_range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._index_range._r_expr._integer).to eq 7
      expect(stmt._declarative_item_list       ).to eq []
      expect(stmt._statement_list              ).to eq []
    end

  end
end
