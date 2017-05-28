require "spec_helper"

describe 'RbVHDL::Ast::Statement::Process' do

  context "new" do

    it "new(nil)" do
      stmt = RbVHDL::Ast::Statement::Process.new(nil)
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Process
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label                 ).to eq nil
      expect(stmt._postponed             ).to eq nil
      expect(stmt._sensitivity_all       ).to eq false
      expect(stmt._sensitivity_list      ).to eq []
      expect(stmt._declarative_item_list ).to eq []
      expect(stmt._statement_list        ).to eq []
    end

    it "RbVHDL::Ast.process_statement(nil)._label!('FSM')" do
      stmt = RbVHDL::Ast.process_statement(nil)._label!('FSM')
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Process
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :FSM
      expect(stmt._postponed             ).to eq nil
      expect(stmt._sensitivity_all       ).to eq false
      expect(stmt._sensitivity_list      ).to eq []
      expect(stmt._declarative_item_list ).to eq []
      expect(stmt._statement_list        ).to eq []
    end

  end

  context "_postponed!" do
    it "RbVHDL::Ast.process_statement(nil)._postponed!._label!('FSM')" do
      stmt = RbVHDL::Ast.process_statement(nil)._postponed!._label!('FSM')
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Process
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :FSM
      expect(stmt._postponed             ).to eq true
      expect(stmt._sensitivity_all       ).to eq false
      expect(stmt._sensitivity_list      ).to eq []
      expect(stmt._declarative_item_list ).to eq []
      expect(stmt._statement_list        ).to eq []
    end
  end
  
  context "_sensitivity_all!" do
    it "RbVHDL::Ast.process_statement(nil)._sensitivity_all!._label!('FSM')" do
      stmt = RbVHDL::Ast.process_statement(nil)._sensitivity_all!._label!('FSM')
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Process
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :FSM
      expect(stmt._postponed             ).to eq nil
      expect(stmt._sensitivity_all       ).to eq true
      expect(stmt._sensitivity_list      ).to eq []
      expect(stmt._declarative_item_list ).to eq []
      expect(stmt._statement_list        ).to eq []
    end
  end

  context "_sensitivity_signal!" do

    it "RbVHDL::Ast.process_statement(nil)._sensitivity_signal!(name('CLK'))._sensitivity_signal!(name('RST'))" do
      stmt = RbVHDL::Ast.process_statement(nil)._sensitivity_signal!(RbVHDL::Ast.name('CLK'))._sensitivity_signal!(RbVHDL::Ast.name('RST'))
      expect(stmt.class                            ).to eq RbVHDL::Ast::Statement::Process
      expect(stmt._owner                           ).to eq nil
      expect(stmt._label                           ).to eq nil
      expect(stmt._postponed                       ).to eq nil
      expect(stmt._sensitivity_all                 ).to eq false
      expect(stmt._sensitivity_list.size           ).to eq 2
      expect(stmt._sensitivity_list[0].class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._sensitivity_list[0]._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._sensitivity_list[0]._name       ).to eq :CLK
      expect(stmt._sensitivity_list[1].class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._sensitivity_list[1]._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._sensitivity_list[1]._name       ).to eq :RST
      expect(stmt._declarative_item_list           ).to eq []
      expect(stmt._statement_list                  ).to eq []
    end

    it "RbVHDL::Ast.process_statement(nil)._sensitivity_signal!(name('CLK'), (name('RST')))" do
      stmt = RbVHDL::Ast.process_statement(nil)._sensitivity_signal!(RbVHDL::Ast.name('CLK'), RbVHDL::Ast.name('RST'))
      expect(stmt.class                            ).to eq RbVHDL::Ast::Statement::Process
      expect(stmt._owner                           ).to eq nil
      expect(stmt._label                           ).to eq nil
      expect(stmt._postponed                       ).to eq nil
      expect(stmt._sensitivity_all                 ).to eq false
      expect(stmt._sensitivity_list.size           ).to eq 2
      expect(stmt._sensitivity_list[0].class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._sensitivity_list[0]._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._sensitivity_list[0]._name       ).to eq :CLK
      expect(stmt._sensitivity_list[1].class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._sensitivity_list[1]._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._sensitivity_list[1]._name       ).to eq :RST
      expect(stmt._declarative_item_list           ).to eq []
      expect(stmt._statement_list                  ).to eq []
    end
  end
  
  context "_simple_variable_assignment_statement" do
    proc  = RbVHDL::Ast.process_statement(nil)
    stmt0 = proc._simple_variable_assignment_statement(RbVHDL::Ast.name('var_0'), RbVHDL::Ast.decimal_literal(0))._label!('V0')
    stmt1 = proc._simple_variable_assignment_statement(RbVHDL::Ast.name('var_1'), RbVHDL::Ast.name('var_0')     )._label!('V1')
    
    it "RbVHDL::Ast.process_statement(nil)" do
      expect(proc.class                  ).to eq RbVHDL::Ast::Statement::Process
      expect(proc._owner                 ).to eq nil
      expect(proc._label                 ).to eq nil
      expect(proc._postponed             ).to eq nil
      expect(proc._sensitivity_all       ).to eq false
      expect(proc._sensitivity_list      ).to eq []
      expect(proc._declarative_item_list ).to eq []
      expect(proc._statement_list.size   ).to eq 2
      expect(proc._statement_list[0]     ).to eq stmt0
      expect(proc._statement_list[1]     ).to eq stmt1
    end
    
    it "_variable_assignment_statement(name('var_0'), decimal_literal(0))" do
      expect(stmt0.class               ).to eq RbVHDL::Ast::Statement::SimpleVariableAssignment
      expect(stmt0._owner              ).to eq proc
      expect(stmt0._label.class        ).to eq RbVHDL::Ast::Label
      expect(stmt0._label              ).to eq :V0
      expect(stmt0._target.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt0._target._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt0._target._name       ).to eq :var_0
      expect(stmt0._value.class        ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt0._value._integer     ).to eq 0
    end

    it "_variable_assignment_statement(name('var_1'), name('var_0'))" do
      expect(stmt1.class               ).to eq RbVHDL::Ast::Statement::SimpleVariableAssignment
      expect(stmt1._owner              ).to eq proc
      expect(stmt1._label.class        ).to eq RbVHDL::Ast::Label
      expect(stmt1._label              ).to eq :V1
      expect(stmt1._target.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt1._target._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt1._target._name       ).to eq :var_1
      expect(stmt1._value.class        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt1._value._name.class  ).to eq RbVHDL::Ast::Identifier
      expect(stmt1._value._name        ).to eq :var_0
    end
  end
end
