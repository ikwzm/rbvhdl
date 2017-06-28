require "spec_helper"

describe 'RbVHDL::Ast::Statement::SimpleSignalAssignment' do

  context "_write_line" do

    it "_simple_signal_assignment_statement('VALID', character_literal('0'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      body._simple_signal_assignment_statement('VALID', RbVHDL::Ast.character_literal('0'))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    VALID <= '0';"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_simple_signal_assignment_statement('VALID', character_literal('0')._label!('VALID_INIT')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      body._simple_signal_assignment_statement('VALID', RbVHDL::Ast.character_literal('0'))._label!('VALID_INIT')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    VALID_INIT: VALID <= '0';"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_simple_signal_assignment_statement('VALID', character_literal('0'))._postponed!" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      body._simple_signal_assignment_statement('VALID', RbVHDL::Ast.character_literal('0'))._postponed!

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    postponed VALID <= '0';"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_simple_signal_assignment_statement('VALID', character_literal('0')).!_after(physical_literal(0, 'ns'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._simple_signal_assignment_statement('VALID', RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(0, 'ns'))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    VALID <= '0' after 0 ns;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_simple_signal_assignment_statement('VALID', character_literal('0'))..." do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._simple_signal_assignment_statement('VALID', RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
      stmt._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(1, 'ns'))
      stmt._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(2, 'ns'))
      stmt._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(3, 'ns'))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    VALID <= '0' after 0 ns,"
      expect(line.shift).to eq "             '1' after 1 ns,"
      expect(line.shift).to eq "             '0' after 2 ns,"
      expect(line.shift).to eq "             '1' after 3 ns;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_simple_signal_assignment_statement('VALID', character_literal('0'))._transport!..." do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._simple_signal_assignment_statement('VALID', RbVHDL::Ast.character_literal('0'))._transport!._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
      stmt._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(1, 'ns'))
      stmt._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(2, 'ns'))
      stmt._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(3, 'ns'))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    VALID <= transport '0' after 0 ns,"
      expect(line.shift).to eq "                       '1' after 1 ns,"
      expect(line.shift).to eq "                       '0' after 2 ns,"
      expect(line.shift).to eq "                       '1' after 3 ns;"
      expect(line.shift).to eq "end     MODEL;"
    end

  end
end

describe 'RbVHDL::Ast::Statement::ConditionalSignalAssignment' do

  context "_write_line" do

    it "_conditional_signal_assignment_statement('VALID', character_literal('0'))._when()" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._conditional_signal_assignment_statement('VALID', RbVHDL::Ast.character_literal('1'))
               ._when!(RbVHDL::Ast.equal(RbVHDL::Ast.name('curr_state'), RbVHDL::Ast.name('VALID_STATE')))
               ._else!(RbVHDL::Ast.character_literal('0'))
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    VALID <= '1' when curr_state = VALID_STATE else"
      expect(line.shift).to eq "             '0';"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_conditional_signal_assignment_statement('DATA')..." do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._conditional_signal_assignment_statement('DATA')
               ._value!(RbVHDL::Ast.name('S1_DATA'  ))._when!(RbVHDL::Ast.equal(RbVHDL::Ast.name('curr_state'), RbVHDL::Ast.name('S1_STATE'  )))._else!
               ._value!(RbVHDL::Ast.name('S10_DATA' ))._when!(RbVHDL::Ast.equal(RbVHDL::Ast.name('curr_state'), RbVHDL::Ast.name('S10_STATE' )))._else!
               ._value!(RbVHDL::Ast.name('S111_DATA'))._when!(RbVHDL::Ast.equal(RbVHDL::Ast.name('curr_state'), RbVHDL::Ast.name('S111_STATE')))._else!
               ._value!( RbVHDL::Ast.name('IDLE_DATA'))
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    DATA <= S1_DATA   when curr_state = S1_STATE   else"
      expect(line.shift).to eq "            S10_DATA  when curr_state = S10_STATE  else"
      expect(line.shift).to eq "            S111_DATA when curr_state = S111_STATE else"
      expect(line.shift).to eq "            IDLE_DATA;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_conditional_signal_assignment_statement('VALID', character_literal('0'))._when()" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._conditional_signal_assignment_statement('VALID')
               ._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(1, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(2, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(3, 'ns'))
               ._when!(RbVHDL::Ast.equal(RbVHDL::Ast.name('curr_state'), RbVHDL::Ast.name('VALID_STATE')))._else!
               ._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(1, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('0'))._after!(RbVHDL::Ast.physical_literal(2, 'ns'))
               ._value!(RbVHDL::Ast.character_literal('1'))._after!(RbVHDL::Ast.physical_literal(3, 'ns'))
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    VALID <= '0' after 0 ns,"
      expect(line.shift).to eq "             '1' after 1 ns,"
      expect(line.shift).to eq "             '0' after 2 ns,"
      expect(line.shift).to eq "             '1' after 3 ns when curr_state = VALID_STATE else"
      expect(line.shift).to eq "             '0' after 0 ns,"
      expect(line.shift).to eq "             '1' after 1 ns,"
      expect(line.shift).to eq "             '0' after 2 ns,"
      expect(line.shift).to eq "             '1' after 3 ns;"
      expect(line.shift).to eq "end     MODEL;"
    end
  end
end

describe 'RbVHDL::Ast::Statement::SelectedSignalAssignment' do

  context "_write_line" do

    it "selected_signal_assignment_statement(nil, name('cond'), name('sig0'))..." do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._selected_signal_assignment_statement(RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'))
               ._value!(3)._when!(3)
               ._value!(2)._when!(2)
               ._value!(1)._when!(1)
               ._value!(0)._when!(RbVHDL::Ast.choice_others)
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    with cond select"
      expect(line.shift).to eq "        sig0 <= 3 when 3,"
      expect(line.shift).to eq "                2 when 2,"
      expect(line.shift).to eq "                1 when 1,"
      expect(line.shift).to eq "                0 when others;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "selected_signal_assignment_statement(nil, name('cond'), name('sig0'))..." do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._selected_signal_assignment_statement(RbVHDL::Ast.name('cond'), RbVHDL::Ast.name('sig0'))
               ._value!(3)._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
               ._value!(0)._after!(RbVHDL::Ast.physical_literal(1, 'ns'))._when!(3)
               ._value!(2)._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
               ._value!(0)._after!(RbVHDL::Ast.physical_literal(1, 'ns'))._when!(2)
               ._value!(1)._after!(RbVHDL::Ast.physical_literal(0, 'ns'))
               ._value!(0)._after!(RbVHDL::Ast.physical_literal(1, 'ns'))._when!(RbVHDL::Ast.choice_others)
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    with cond select"
      expect(line.shift).to eq "        sig0 <= 3 after 0 ns,"
      expect(line.shift).to eq "                0 after 1 ns when 3,"
      expect(line.shift).to eq "                2 after 0 ns,"
      expect(line.shift).to eq "                0 after 1 ns when 2,"
      expect(line.shift).to eq "                1 after 0 ns,"
      expect(line.shift).to eq "                0 after 1 ns when others;"
      expect(line.shift).to eq "end     MODEL;"
    end
  end
end
