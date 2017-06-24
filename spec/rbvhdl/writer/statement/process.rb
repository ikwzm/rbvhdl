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
      expect(line.shift).to eq "end     MODEL;"
    end

  end
end
