require "spec_helper"

describe 'RbVHDL::Ast::Statement::Case' do

  context "_write_line" do

    it "case_statement(RbVHDL::Ast.name('case_signal'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST') {
          _process_statement {
            _case_statement(RbVHDL::Ast.name('case_signal'))
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        case case_signal is"
      expect(line.shift).to eq "        end case;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "case_statement(RbVHDL::Ast.name('case_signal'))._label!('SIG_CASE')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST') {
          _process_statement {
            _case_statement(RbVHDL::Ast.name('case_signal'))._label!('SIG_CASE')
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        SIG_CASE: case case_signal is"
      expect(line.shift).to eq "        end case;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "case_statement(RbVHDL::Ast.name('case_signal'))._label!('SIG_CASE')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST') {
          _process_statement {
            _case_statement(RbVHDL::Ast.name('case_signal'))._label!('SIG_CASE')
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        SIG_CASE: case case_signal is"
      expect(line.shift).to eq "        end case;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "case_statement(RbVHDL::Ast.name('curr_state'))._when!(...){...}..." do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST') {
          _process_statement {
            _case_statement(RbVHDL::Ast.name('curr_state')){
              _when!(RbVHDL::Ast.choice_identifier('IDLE_STATE')) {
                _signal_assignment_statement(RbVHDL::Ast.name('s')  , RbVHDL::Ast.name('data'))
              }
              _when!(RbVHDL::Ast.choice_identifier('RUN_STATE'))  {
                _signal_assignment_statement(RbVHDL::Ast.name('ss') , RbVHDL::Ast.name('data'))
              }
              _when!(RbVHDL::Ast.choice_others) {
                _signal_assignment_statement(RbVHDL::Ast.name('sss'), RbVHDL::Ast.name('data'))
              }
            }
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        case curr_state is"
      expect(line.shift).to eq "            when IDLE_STATE =>"
      expect(line.shift).to eq "                s   <= data;"
      expect(line.shift).to eq "            when RUN_STATE  =>"
      expect(line.shift).to eq "                ss  <= data;"
      expect(line.shift).to eq "            when others     =>"
      expect(line.shift).to eq "                sss <= data;"
      expect(line.shift).to eq "        end case;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end
  end
end

