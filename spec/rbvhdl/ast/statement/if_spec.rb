require "spec_helper"

describe 'RbVHDL::Ast::Statement::If' do

  context "new" do

    it "new(nil, name('cond_0'))" do
      stmt = RbVHDL::Ast::Statement::If.new(nil, RbVHDL::Ast.name('cond_0'))
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::If
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label                 ).to eq nil
      expect(stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._condition._name       ).to eq :cond_0
      expect(stmt._statement_list        ).to eq []
      expect(stmt._else_list             ).to eq []
    end

    it "RbVHDL::Ast.if_statement(nil, name('cond_0'))._label!('IF_COND0')" do
      stmt = RbVHDL::Ast.if_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::If
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :IF_COND0
      expect(stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._condition._name       ).to eq :cond_0
      expect(stmt._statement_list        ).to eq []
      expect(stmt._else_list             ).to eq []
    end
  end

  context "_elsif_statement and _else_statement" do

    it "RbVHDL::Ast.if_statement(nil, name('cond_0')) ... _elsif_statement(name('cond_1'))" do
      if_stmt = RbVHDL::Ast.if_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')
      if_stmt._null_statement
      e0_stmt = if_stmt._elsif_statement(RbVHDL::Ast.name('cond_1'))
      e0_stmt._null_statement
      expect(if_stmt.class                    ).to eq RbVHDL::Ast::Statement::If
      expect(if_stmt._owner                   ).to eq nil
      expect(if_stmt._label.class             ).to eq RbVHDL::Ast::Label
      expect(if_stmt._label                   ).to eq :IF_COND0
      expect(if_stmt._condition.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(if_stmt._condition._name.class   ).to eq RbVHDL::Ast::Identifier
      expect(if_stmt._condition._name         ).to eq :cond_0
      expect(if_stmt._statement_list.size     ).to eq 1
      expect(if_stmt._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(if_stmt._statement_list[0]._owner).to eq if_stmt
      expect(if_stmt._statement_list[0]._label).to eq nil
      expect(if_stmt._else_list               ).to eq [e0_stmt]
      expect(e0_stmt.class                    ).to eq RbVHDL::Ast::Statement::Elsif
      expect(e0_stmt._owner                   ).to eq if_stmt
      expect(e0_stmt._condition.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(e0_stmt._condition._name.class   ).to eq RbVHDL::Ast::Identifier
      expect(e0_stmt._condition._name         ).to eq :cond_1
      expect(e0_stmt._statement_list.size     ).to eq 1
      expect(e0_stmt._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(e0_stmt._statement_list[0]._owner).to eq e0_stmt
      expect(e0_stmt._statement_list[0]._label).to eq nil
    end

    it "RbVHDL::Ast.if_statement(nil, name('cond_0')) ... _else_statement" do
      if_stmt = RbVHDL::Ast.if_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')
      if_stmt._null_statement
      e0_stmt = if_stmt._else_statement
      e0_stmt._null_statement
      expect(if_stmt.class                    ).to eq RbVHDL::Ast::Statement::If
      expect(if_stmt._owner                   ).to eq nil
      expect(if_stmt._label.class             ).to eq RbVHDL::Ast::Label
      expect(if_stmt._label                   ).to eq :IF_COND0
      expect(if_stmt._condition.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(if_stmt._condition._name.class   ).to eq RbVHDL::Ast::Identifier
      expect(if_stmt._condition._name         ).to eq :cond_0
      expect(if_stmt._statement_list.size     ).to eq 1
      expect(if_stmt._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(if_stmt._statement_list[0]._owner).to eq if_stmt
      expect(if_stmt._statement_list[0]._label).to eq nil
      expect(if_stmt._else_list               ).to eq [e0_stmt]
      expect(e0_stmt.class                    ).to eq RbVHDL::Ast::Statement::Else
      expect(e0_stmt._owner                   ).to eq if_stmt
      expect(e0_stmt._statement_list.size     ).to eq 1
      expect(e0_stmt._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(e0_stmt._statement_list[0]._owner).to eq e0_stmt
      expect(e0_stmt._statement_list[0]._label).to eq nil
    end

    it "RbVHDL::Ast.if_statement(nil, name('cond_0')) ... _elsif_statement(name('cond_1')) ... _else_statement" do
      if_stmt = RbVHDL::Ast.if_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')
      if_stmt._null_statement
      e0_stmt = if_stmt._elsif_statement(RbVHDL::Ast.name('cond_1'))
      e0_stmt._null_statement
      e1_stmt = if_stmt._else_statement
      e1_stmt._null_statement
      expect(if_stmt.class                    ).to eq RbVHDL::Ast::Statement::If
      expect(if_stmt._owner                   ).to eq nil
      expect(if_stmt._label.class             ).to eq RbVHDL::Ast::Label
      expect(if_stmt._label                   ).to eq :IF_COND0
      expect(if_stmt._condition.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(if_stmt._condition._name.class   ).to eq RbVHDL::Ast::Identifier
      expect(if_stmt._condition._name         ).to eq :cond_0
      expect(if_stmt._statement_list.size     ).to eq 1
      expect(if_stmt._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(if_stmt._statement_list[0]._owner).to eq if_stmt
      expect(if_stmt._statement_list[0]._label).to eq nil
      expect(if_stmt._else_list               ).to eq [e0_stmt, e1_stmt]
      expect(e0_stmt.class                    ).to eq RbVHDL::Ast::Statement::Elsif
      expect(e0_stmt._owner                   ).to eq if_stmt
      expect(e0_stmt._condition.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(e0_stmt._condition._name.class   ).to eq RbVHDL::Ast::Identifier
      expect(e0_stmt._condition._name         ).to eq :cond_1
      expect(e0_stmt._statement_list.size     ).to eq 1
      expect(e0_stmt._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(e0_stmt._statement_list[0]._owner).to eq e0_stmt
      expect(e0_stmt._statement_list[0]._label).to eq nil
      expect(e1_stmt.class                    ).to eq RbVHDL::Ast::Statement::Else
      expect(e1_stmt._owner                   ).to eq if_stmt
      expect(e1_stmt._statement_list.size     ).to eq 1
      expect(e1_stmt._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(e1_stmt._statement_list[0]._owner).to eq e1_stmt
      expect(e1_stmt._statement_list[0]._label).to eq nil
    end

  end
end
