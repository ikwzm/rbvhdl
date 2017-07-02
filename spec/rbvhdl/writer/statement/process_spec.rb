require "spec_helper"

describe 'RbVHDL::Ast::Statement::Process' do

  context "_write_line" do

    it "_process_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "_process_statement._label!('FSM')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement._label!('FSM')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    FSM: process begin"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "_process_statement._postponed!" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement._postponed!

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    postponed process begin"
      expect(line.shift).to eq "    end postponed process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "_process_statement._sensitivity_all!" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement._sensitivity_all!

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process all begin"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "_process_statement._sensitivity_signal!('CLK','RST')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement._sensitivity_signal!('CLK','RST')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process(CLK, RST) begin"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "_process_statement._sensitivity_signal!('CLK','RST')..." do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement._sensitivity_signal!('CLK','RST')
      proc._variable_declaration 'valid', 'boolean'

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process(CLK, RST)"
      expect(line.shift).to eq "        variable  valid   :  boolean;"
      expect(line.shift).to eq "    begin"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

  end
end
