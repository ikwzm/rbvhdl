require "spec_helper"

describe 'RbVHDL::Ast::Statement::Case' do

  context "new" do

    it "new(nil, name('curr_state'))" do
      stmt = RbVHDL::Ast::Statement::Case.new(nil, RbVHDL::Ast.name('curr_state'))
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Case
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label                 ).to eq nil
      expect(stmt._expression.class      ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name      ).to eq :curr_state
      expect(stmt._when_list             ).to eq []
    end

    it "RbVHDL::Ast.case_statement(nil, name('curr_state'))._label!('FSM')" do
      stmt = RbVHDL::Ast.case_statement(nil, RbVHDL::Ast.name('curr_state'))._label!('FSM')
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Case
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :FSM
      expect(stmt._expression.class      ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name      ).to eq :curr_state
    end
  end

  context "_when_statement" do
    
    it "RbVHDL::Ast.case_statement(nil, name('curr_state'))._when(choice_identifier('IDLE_STATE')) ... _when(choice_others)" do
      stmt = RbVHDL::Ast.case_statement(nil, RbVHDL::Ast.name('curr_state'))
      idle_state  = stmt._when_statement(RbVHDL::Ast.choice_identifier('IDLE_STATE'))
      idle_state._null_statement._label!("NULL_IDLE")
      other_state = stmt._when_statement(RbVHDL::Ast.choice_others)
      other_state._null_statement._label!("NULL_OTHERS")
      expect(stmt._when_list.size                        ).to eq 2
      expect(stmt._when_list[0].class                    ).to eq RbVHDL::Ast::Statement::Case::When
      expect(stmt._when_list[0]._owner                   ).to eq stmt
      expect(stmt._when_list[0]._choices.class           ).to eq RbVHDL::Ast::Expression::ChoiceIdentifier
      expect(stmt._when_list[0]._choices._name           ).to eq :IDLE_STATE
      expect(stmt._when_list[0]._statement_list.size     ).to eq 1
      expect(stmt._when_list[0]._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(stmt._when_list[0]._statement_list[0]._owner).to eq idle_state
      expect(stmt._when_list[0]._statement_list[0]._label).to eq :NULL_IDLE
      expect(stmt._when_list[1].class                    ).to eq RbVHDL::Ast::Statement::Case::When
      expect(stmt._when_list[1]._owner                   ).to eq stmt
      expect(stmt._when_list[1]._choices.class           ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      expect(stmt._when_list[1]._statement_list.size     ).to eq 1
      expect(stmt._when_list[1]._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(stmt._when_list[1]._statement_list[0]._owner).to eq other_state
      expect(stmt._when_list[1]._statement_list[0]._label).to eq :NULL_OTHERS
    end
  end

  context "_when!" do
    it do
      stmt = RbVHDL::Ast.case_statement(nil, RbVHDL::Ast.name('curr_state')) {
        _when!(RbVHDL::Ast.choice_identifier('IDLE_STATE')) {
          _null_statement._label!('NULL_IDLE')
        }
        _when!(RbVHDL::Ast.choice_others) {
          _null_statement._label!('NULL_OTHERS')
        }
      }
      expect(stmt._when_list.size                        ).to eq 2
      expect(stmt._when_list[0].class                    ).to eq RbVHDL::Ast::Statement::Case::When
      expect(stmt._when_list[0]._owner                   ).to eq stmt
      expect(stmt._when_list[0]._choices.class           ).to eq RbVHDL::Ast::Expression::ChoiceIdentifier
      expect(stmt._when_list[0]._choices._name           ).to eq :IDLE_STATE
      expect(stmt._when_list[0]._statement_list.size     ).to eq 1
      expect(stmt._when_list[0]._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(stmt._when_list[0]._statement_list[0]._owner).to eq stmt._when_list[0]
      expect(stmt._when_list[0]._statement_list[0]._label).to eq :NULL_IDLE
      expect(stmt._when_list[1].class                    ).to eq RbVHDL::Ast::Statement::Case::When
      expect(stmt._when_list[1]._owner                   ).to eq stmt
      expect(stmt._when_list[1]._choices.class           ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      expect(stmt._when_list[1]._statement_list.size     ).to eq 1
      expect(stmt._when_list[1]._statement_list[0].class ).to eq RbVHDL::Ast::Statement::Null
      expect(stmt._when_list[1]._statement_list[0]._owner).to eq stmt._when_list[1]
      expect(stmt._when_list[1]._statement_list[0]._label).to eq :NULL_OTHERS
    end
  end
end
