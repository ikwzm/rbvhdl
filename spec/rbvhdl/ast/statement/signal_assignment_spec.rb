require "spec_helper"

describe 'RbVHDL::Ast::Statement::SimpleSignalAssignment' do

  context "new" do

    it "new(nil, name('sig0'), waveform(character_literal('0')))" do
      stmt = RbVHDL::Ast::Statement::SimpleSignalAssignment.new(nil, RbVHDL::Ast.name('sig0'), RbVHDL::Ast.waveform(RbVHDL::Ast.character_literal('0')))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig0
      expect(stmt._waveform.class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size        ).to eq 1
      expect(stmt._waveform._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value).to eq "0"
      expect(stmt._waveform._list[0][1]       ).to eq nil
      expect(stmt._postponed                  ).to eq nil
      expect(stmt._guarded                    ).to eq nil
      expect(stmt._delay                      ).to eq nil
    end

    it "new(nil, name('sig0'))._value!(character_literal('0'))" do
      stmt = RbVHDL::Ast::Statement::SimpleSignalAssignment.new(nil, RbVHDL::Ast.name('sig0'))
               ._value!(RbVHDL::Ast.waveform(RbVHDL::Ast.character_literal('0')))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig0
      expect(stmt._waveform.class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size        ).to eq 1
      expect(stmt._waveform._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value).to eq "0"
      expect(stmt._waveform._list[0][1]       ).to eq nil
      expect(stmt._postponed                  ).to eq nil
      expect(stmt._guarded                    ).to eq nil
      expect(stmt._delay                      ).to eq nil
    end
  end

  context "simple_signal_assignment_statement()" do

    it "simple_signal_assignment_statement(nil, name('sig1'), character_literal('1'))" do
      stmt = RbVHDL::Ast.simple_signal_assignment_statement(nil, RbVHDL::Ast.name('sig1'), RbVHDL::Ast.character_literal('1'))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig1
      expect(stmt._waveform.class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size        ).to eq 1
      expect(stmt._waveform._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value).to eq "1"
      expect(stmt._waveform._list[0][1]       ).to eq nil
      expect(stmt._postponed                  ).to eq nil
      expect(stmt._guarded                    ).to eq nil
      expect(stmt._delay                      ).to eq nil
    end

    it "signal_assignment_statement(nil, name('sig1'))._value(character_literal('1'))" do
      stmt = RbVHDL::Ast.simple_signal_assignment_statement(nil, RbVHDL::Ast.name('sig1'))._value!(RbVHDL::Ast.character_literal('1'))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig1
      expect(stmt._waveform.class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size        ).to eq 1
      expect(stmt._waveform._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value).to eq "1"
      expect(stmt._waveform._list[0][1]       ).to eq nil
      expect(stmt._postponed                  ).to eq nil
      expect(stmt._guarded                    ).to eq nil
      expect(stmt._delay                      ).to eq nil
    end

    it "signal_assignment_statement(nil, name('sig1'))._value(character_literal('0')._after!(RbVHDL::Ast.physical_literal(0, 'ns'))..." do
      stmt = RbVHDL::Ast.simple_signal_assignment_statement(nil, RbVHDL::Ast.name('sig1'))
               ._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(1, 'ns'))
      expect(stmt.class                                  ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                                 ).to eq nil
      expect(stmt._label                                 ).to eq nil
      expect(stmt._target.class                          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                    ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                          ).to eq :sig1
      expect(stmt._waveform.class                        ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size                   ).to eq 2
      expect(stmt._waveform._list[0][0].class            ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value           ).to eq "0"
      expect(stmt._waveform._list[0][1].class            ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
      expect(stmt._waveform._list[0][1]._decimal.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform._list[0][1]._decimal._integer).to eq 0
      expect(stmt._waveform._list[0][1]._unit_name.class ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform._list[0][1]._unit_name._name ).to eq :ns
      expect(stmt._waveform._list[1][0].class            ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[1][0]._value           ).to eq "1"
      expect(stmt._waveform._list[1][1].class            ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
      expect(stmt._waveform._list[1][1]._decimal.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform._list[1][1]._decimal._integer).to eq 1
      expect(stmt._waveform._list[1][1]._unit_name.class ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform._list[1][1]._unit_name._name ).to eq :ns
      expect(stmt._postponed                             ).to eq nil
      expect(stmt._guarded                               ).to eq nil
      expect(stmt._delay                                 ).to eq nil
    end

  end
  
  context "signal_assignment_statement()" do
    it "assignment_statement(nil, name('sig1'))._value(character_literal('0')._after!(RbVHDL::Ast.physical_literal(0, 'ns'))..." do
      stmt = RbVHDL::Ast.signal_assignment_statement(nil, RbVHDL::Ast.name('sig1'))
               ._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(1, 'ns'))
      expect(stmt.class                                  ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                                 ).to eq nil
      expect(stmt._label                                 ).to eq nil
      expect(stmt._target.class                          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                    ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                          ).to eq :sig1
      expect(stmt._waveform.class                        ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size                   ).to eq 2
      expect(stmt._waveform._list[0][0].class            ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value           ).to eq "0"
      expect(stmt._waveform._list[0][1].class            ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
      expect(stmt._waveform._list[0][1]._decimal.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform._list[0][1]._decimal._integer).to eq 0
      expect(stmt._waveform._list[0][1]._unit_name.class ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform._list[0][1]._unit_name._name ).to eq :ns
      expect(stmt._waveform._list[1][0].class            ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[1][0]._value           ).to eq "1"
      expect(stmt._waveform._list[1][1].class            ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
      expect(stmt._waveform._list[1][1]._decimal.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform._list[1][1]._decimal._integer).to eq 1
      expect(stmt._waveform._list[1][1]._unit_name.class ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform._list[1][1]._unit_name._name ).to eq :ns
      expect(stmt._postponed                             ).to eq nil
      expect(stmt._guarded                               ).to eq nil
      expect(stmt._delay                                 ).to eq nil
    end
  end

end

describe 'RbVHDL::Ast::Statement::ConditionalSignalAssignment' do

  context "new" do

    it "new(nil, name('sig0'))" do
      stmt = RbVHDL::Ast::Statement::ConditionalSignalAssignment.new(nil, RbVHDL::Ast.name('sig0'))
      expect(stmt.class                                  ).to eq RbVHDL::Ast::Statement::ConditionalSignalAssignment
      expect(stmt._owner                                 ).to eq nil
      expect(stmt._label                                 ).to eq nil
      expect(stmt._target.class                          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                    ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                          ).to eq :sig0
      expect(stmt._waveform_list                         ).to eq []
      expect(stmt._postponed                             ).to eq nil
      expect(stmt._guarded                               ).to eq nil
      expect(stmt._delay                                 ).to eq nil
    end

    it "new(nil, name('sig0'), waveform(character_literal('0')))" do
      stmt = RbVHDL::Ast::Statement::ConditionalSignalAssignment.new(nil, RbVHDL::Ast.name('sig0'), RbVHDL::Ast.waveform(RbVHDL::Ast.character_literal('0')))
      expect(stmt.class                                  ).to eq RbVHDL::Ast::Statement::ConditionalSignalAssignment
      expect(stmt._owner                                 ).to eq nil
      expect(stmt._label                                 ).to eq nil
      expect(stmt._target.class                          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                    ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                          ).to eq :sig0
      expect(stmt._waveform_list.size                    ).to eq 1
      expect(stmt._waveform_list[0][0].class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size        ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._value).to eq "0"
      expect(stmt._waveform_list[0][0]._list[0][1]       ).to eq nil
      expect(stmt._waveform_list[0][1]                   ).to eq nil
      expect(stmt._postponed                             ).to eq nil
      expect(stmt._guarded                               ).to eq nil
      expect(stmt._delay                                 ).to eq nil
    end
  end

  context "conditional_signal_assignment_statement" do

    it "conditional_signal_assignment_statement(nil, 'sig0')" do
      stmt = RbVHDL::Ast.conditional_signal_assignment_statement(nil, 'sig0')
      expect(stmt.class                                  ).to eq RbVHDL::Ast::Statement::ConditionalSignalAssignment
      expect(stmt._owner                                 ).to eq nil
      expect(stmt._label                                 ).to eq nil
      expect(stmt._target.class                          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                    ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                          ).to eq :sig0
      expect(stmt._waveform_list                         ).to eq []
      expect(stmt._postponed                             ).to eq nil
      expect(stmt._guarded                               ).to eq nil
      expect(stmt._delay                                 ).to eq nil
    end

    it "conditional_signal_assignment_statement(nil, 'sig0', character_literal('0'))" do
      stmt = RbVHDL::Ast.conditional_signal_assignment_statement(nil, 'sig0', RbVHDL::Ast.character_literal('0'))
      expect(stmt.class                                  ).to eq RbVHDL::Ast::Statement::ConditionalSignalAssignment
      expect(stmt._owner                                 ).to eq nil
      expect(stmt._label                                 ).to eq nil
      expect(stmt._target.class                          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                    ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                          ).to eq :sig0
      expect(stmt._waveform_list.size                    ).to eq 1
      expect(stmt._waveform_list[0][0].class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size        ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._value).to eq "0"
      expect(stmt._waveform_list[0][0]._list[0][1]       ).to eq nil
      expect(stmt._waveform_list[0][1]                   ).to eq nil
      expect(stmt._postponed                             ).to eq nil
      expect(stmt._guarded                               ).to eq nil
      expect(stmt._delay                                 ).to eq nil
    end

    it "conditional_signal_assignment_statement(nil, 'sig0')..." do
      stmt = RbVHDL::Ast.conditional_signal_assignment_statement(nil, 'sig0')
               ._value!(1)._when!(RbVHDL::Ast.name('s1_state'))._else!(0)
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::ConditionalSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._waveform_list.size                      ).to eq 2
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[0][1].class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform_list[0][1]._name               ).to eq :s1_state
      expect(stmt._waveform_list[1][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[1][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[1][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[1][0]._list[0][0]._integer).to eq 0
      expect(stmt._waveform_list[1][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[1][1]                     ).to eq nil
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end

    it "conditional_signal_assignment_statement(nil, 'sig0')..." do
      stmt = RbVHDL::Ast.conditional_signal_assignment_statement(nil, 'sig0')
               ._value!(3)._when!(RbVHDL::Ast.name('s3_state'))._else!
               ._value!(2)._when!(RbVHDL::Ast.name('s2_state'))._else!
               ._value!(1)._when!(RbVHDL::Ast.name('s1_state'))._else!
               ._value!(0)
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::ConditionalSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._waveform_list.size                      ).to eq 4
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 3
      expect(stmt._waveform_list[0][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[0][1].class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform_list[0][1]._name               ).to eq :s3_state
      expect(stmt._waveform_list[1][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[1][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[1][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[1][0]._list[0][0]._integer).to eq 2
      expect(stmt._waveform_list[1][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[1][1].class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform_list[1][1]._name               ).to eq :s2_state
      expect(stmt._waveform_list[2][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[2][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[2][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[2][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[2][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[2][1].class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform_list[2][1]._name               ).to eq :s1_state
      expect(stmt._waveform_list[3][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[3][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[3][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[3][0]._list[0][0]._integer).to eq 0
      expect(stmt._waveform_list[3][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[3][1]                     ).to eq nil
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end
  end

  context "signal_assignment_statement()._when()" do
    it "signal_assignment_statement(nil, 'sig0',1)._when(name('s1_state'))._else!(0)" do
      stmt = RbVHDL::Ast.signal_assignment_statement(nil, 'sig0', 1)._when!(RbVHDL::Ast.name('s1_state'))._else!(0)
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::ConditionalSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._waveform_list.size                      ).to eq 2
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[0][1].class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._waveform_list[0][1]._name               ).to eq :s1_state
      expect(stmt._waveform_list[1][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[1][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[1][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[1][0]._list[0][0]._integer).to eq 0
      expect(stmt._waveform_list[1][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[1][1]                     ).to eq nil
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end
  end
  
end

describe 'RbVHDL::Ast::Statement::SelectedSignalAssignment' do

  context "new" do

    it "new(nil, name('cond'), name('sig0'))" do
      stmt = RbVHDL::Ast::Statement::SelectedSignalAssignment.new(nil, RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'))
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::SelectedSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name                        ).to eq :cond
      expect(stmt._waveform_list                           ).to eq []
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end

    it "new(nil, name('cond'), name('sig0'), waveform(1))" do
      stmt = RbVHDL::Ast::Statement::SelectedSignalAssignment.new(nil, RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'), RbVHDL::Ast.waveform(1))
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::SelectedSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name                        ).to eq :cond
      expect(stmt._waveform_list.size                      ).to eq 1
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][1]         ).to eq nil
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end

    it "new(nil, name('cond'), name('sig0'), waveform(1), choices(1))" do
      stmt = RbVHDL::Ast::Statement::SelectedSignalAssignment.new(nil, RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'), RbVHDL::Ast.waveform(1), RbVHDL::Ast.choices(1))
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::SelectedSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name                        ).to eq :cond
      expect(stmt._waveform_list.size                      ).to eq 1
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[0][1].class               ).to eq RbVHDL::Ast::Expression::ChoiceExpression
      expect(stmt._waveform_list[0][1]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][1]._expression._integer).to eq 1
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end
  end

  context "selected_signal_assignment_statement" do
    
    it "selected_signal_assignment_statement(nil, name('cond'), name('sig0'))" do
      stmt = RbVHDL::Ast.selected_signal_assignment_statement(nil, RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'))
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::SelectedSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name                        ).to eq :cond
      expect(stmt._waveform_list                           ).to eq []
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end

    it "selected_signal_assignment_statement(nil, name('cond'), name('sig0'), 1)" do
      stmt = RbVHDL::Ast.selected_signal_assignment_statement(nil, RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'), 1)
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::SelectedSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name                        ).to eq :cond
      expect(stmt._waveform_list.size                      ).to eq 1
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][1]         ).to eq nil
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end

    it "selected_signal_assignment_statement(nil, name('cond'), name('sig0'), 1, 1)" do
      stmt = RbVHDL::Ast.selected_signal_assignment_statement(nil, RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'), 1, 1)
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::SelectedSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name                        ).to eq :cond
      expect(stmt._waveform_list.size                      ).to eq 1
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[0][1].class               ).to eq RbVHDL::Ast::Expression::ChoiceExpression
      expect(stmt._waveform_list[0][1]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][1]._expression._integer).to eq 1
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end

    it "selected_signal_assignment_statement(nil, name('cond'), name('sig0'))..." do
      stmt = RbVHDL::Ast.selected_signal_assignment_statement(nil, RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'))
               ._value!(3)._when!(3)
               ._value!(2)._when!(2)
               ._value!(1)._when!(1)
               ._value!(0)._when!(RbVHDL::Ast.choice_others)
      expect(stmt.class                                    ).to eq RbVHDL::Ast::Statement::SelectedSignalAssignment
      expect(stmt._owner                                   ).to eq nil
      expect(stmt._label                                   ).to eq nil
      expect(stmt._target.class                            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class                      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name                            ).to eq :sig0
      expect(stmt._expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(stmt._expression._name                        ).to eq :cond
      expect(stmt._waveform_list.size                      ).to eq 4
      expect(stmt._waveform_list[0][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[0][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[0][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][0]._list[0][0]._integer).to eq 3
      expect(stmt._waveform_list[0][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[0][1].class               ).to eq RbVHDL::Ast::Expression::ChoiceExpression
      expect(stmt._waveform_list[0][1]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[0][1]._expression._integer).to eq 3
      expect(stmt._waveform_list[1][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[1][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[1][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[1][0]._list[0][0]._integer).to eq 2
      expect(stmt._waveform_list[1][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[1][1].class               ).to eq RbVHDL::Ast::Expression::ChoiceExpression
      expect(stmt._waveform_list[1][1]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[1][1]._expression._integer).to eq 2
      expect(stmt._waveform_list[2][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[2][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[2][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[2][0]._list[0][0]._integer).to eq 1
      expect(stmt._waveform_list[2][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[2][1].class               ).to eq RbVHDL::Ast::Expression::ChoiceExpression
      expect(stmt._waveform_list[2][1]._expression.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[2][1]._expression._integer).to eq 1
      expect(stmt._waveform_list[3][0].class               ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform_list[3][0]._list.size          ).to eq 1
      expect(stmt._waveform_list[3][0]._list[0][0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._waveform_list[3][0]._list[0][0]._integer).to eq 0
      expect(stmt._waveform_list[3][0]._list[0][1]         ).to eq nil
      expect(stmt._waveform_list[3][1].class               ).to eq RbVHDL::Ast::Expression::ChoiceOthers
      expect(stmt._postponed                               ).to eq nil
      expect(stmt._guarded                                 ).to eq nil
      expect(stmt._delay                                   ).to eq nil
    end

  end
  
end
