require "spec_helper"

describe 'RbVHDL::Ast::Statement::SimpleVariableAssignment' do

  context "_write_line" do

    it "simple_variable_assignment_statement(nil, 'sig0', 0)" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      proc._variable_assignment_statement('sig0'  , 0)
      proc._variable_assignment_statement('sig10' , 10)
      proc._variable_assignment_statement('sig100', 100)
      
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        sig0   := 0;"
      expect(line.shift).to eq "        sig10  := 10;"
      expect(line.shift).to eq "        sig100 := 100;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

  end
  
end

