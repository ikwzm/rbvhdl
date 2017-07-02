require "spec_helper"

describe 'RbVHDL::Ast::Statement::Null' do

  context "_write_line" do

    it "_null_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      null = proc._null_statement

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        null;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "_null_statement._label!('L_NULL')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      null = proc._null_statement._label!('L_NULL')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        L_NULL: null;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end
  end
end

