require "spec_helper"

describe 'RbVHDL::Ast::Statement::If' do

  context "_write_line" do

    it "if_statement(RbVHDL::Ast.name('cond_0'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST') {
          _process_statement {
            _if_statement(RbVHDL::Ast.name('cond_0'))
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if cond_0 then"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "if_statement(RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST'){
          _process_statement {
            _if_statement(RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        IF_COND0: if cond_0 then"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end
  end

  context "_elsif_statement and _else_statement" do

    it "if_statement(name('cond_0')) ... _elsif_statement(name('cond_1'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new{
        _architecture('MODEL', 'TEST') {
          _process_statement {
            _if_statement(RbVHDL::Ast.name('cond_0')) {
              _null_statement._label!("NULL_IF_0")
            }._elsif_statement(RbVHDL::Ast.name('cond_1')) {
              _null_statement._label!("NULL_IF_1")
            }
          }
        }
      }
      
      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if    cond_0 then"
      expect(line.shift).to eq "            NULL_IF_0: null;"
      expect(line.shift).to eq "        elsif cond_1 then"
      expect(line.shift).to eq "            NULL_IF_1: null;"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "if_statement(name('cond_0')) ... _else_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST'){
          _process_statement {
            _if_statement(RbVHDL::Ast.name('cond_0')) {
              _null_statement._label!("NULL_IF_0")
            }._else_statement {
              _null_statement._label!("NULL_ELSE")
            }
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if cond_0 then"
      expect(line.shift).to eq "            NULL_IF_0: null;"
      expect(line.shift).to eq "        else"
      expect(line.shift).to eq "            NULL_ELSE: null;"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end
  end
  
  context "_elsif! and _else!" do

    it "if_statement(name('cond_0')){...}._elsif!(name('cond_1')){...}._else!{...}" do
      design_unit = RbVHDL::Ast::DesignUnit.new {
        _architecture('MODEL', 'TEST') {
          _process_statement {
            _if_statement(RbVHDL::Ast.name('cond_0')) {
              _signal_assignment_statement(RbVHDL::Ast.name('s'  ), RbVHDL::Ast.name('data'))
            }._elsif!(RbVHDL::Ast.name('cond_1')) {
              _signal_assignment_statement(RbVHDL::Ast.name('ss' ), RbVHDL::Ast.name('data'))
            }._else! {
              _signal_assignment_statement(RbVHDL::Ast.name('sss'), RbVHDL::Ast.name('data'))
            }
          }
        }
      }

      line = design_unit._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if    cond_0 then"
      expect(line.shift).to eq "            s   <= data;"
      expect(line.shift).to eq "        elsif cond_1 then"
      expect(line.shift).to eq "            ss  <= data;"
      expect(line.shift).to eq "        else"
      expect(line.shift).to eq "            sss <= data;"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end
  end
end
