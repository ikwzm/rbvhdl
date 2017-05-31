require "spec_helper"

describe 'RbVHDL::Ast::Statement::Assertion' do

  context "new" do

    it "new(nil, name('true'))" do
      stmt = RbVHDL::Ast::Statement::Assertion.new(nil, RbVHDL::Ast.name('true'))
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Assertion
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label                 ).to eq nil
      expect(stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._condition._name       ).to eq :true
      expect(stmt._report                ).to eq nil
      expect(stmt._severity              ).to eq nil
    end

    it "RbVHDL::Ast.assertion_statement(nil, name('true'))._label!('L')._report!(name('report'))._severity!(name('severity'))" do
      stmt = RbVHDL::Ast.assertion_statement(nil, RbVHDL::Ast.name('true'))._label!('L')._report!(RbVHDL::Ast.name('report'))._severity!(RbVHDL::Ast.name('severity'))
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Assertion
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :L
      expect(stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._condition._name       ).to eq :true
      expect(stmt._report.class          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._report._name.class    ).to eq RbVHDL::Ast::Identifier
      expect(stmt._report._name          ).to eq :report
      expect(stmt._severity.class        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._severity._name.class  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._severity._name        ).to eq :severity
    end

  end
end
