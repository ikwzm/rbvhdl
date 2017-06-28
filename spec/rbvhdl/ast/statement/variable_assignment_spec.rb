require "spec_helper"

describe 'RbVHDL::Ast::Statement::SimpleVariableAssignment' do

  context "new" do

    it "new(nil, name('sig0'), character_literal('0'))" do
      stmt = RbVHDL::Ast::Statement::SimpleVariableAssignment.new(nil, RbVHDL::Ast.name('sig0'), RbVHDL::Ast.character_literal('0'))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleVariableAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig0
      expect(stmt._value.class                ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._value._value               ).to eq "0"
    end

    it "new(nil, name('sig0'))._value!(character_literal('0'))" do
      stmt = RbVHDL::Ast::Statement::SimpleVariableAssignment.new(nil, RbVHDL::Ast.name('sig0'))
               ._value!(RbVHDL::Ast.character_literal('0'))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleVariableAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig0
      expect(stmt._value.class                ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._value._value               ).to eq "0"
    end
  end

  context "simple_variable_assignment_statement" do
    
    it "simple_variable_assignment_statement(nil, 'sig0', 0)" do
      stmt = RbVHDL::Ast.simple_variable_assignment_statement(nil, 'sig0', 0)
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleVariableAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig0
      expect(stmt._value.class                ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._value._integer             ).to eq 0
    end

  end
  
end

