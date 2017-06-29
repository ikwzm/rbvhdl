require "spec_helper"

describe 'RbVHDL::Ast::Statement::IfGenerate' do

  context "_write_line" do

    it "_if_generate_statement('IF_COND0', name('cond_0'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._if_generate_statement('IF_COND0', RbVHDL::Ast.name('cond_0'))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    IF_COND0: if cond_0 generate"
      expect(line.shift).to eq "    end generate;"
      expect(line.shift).to eq "end MODEL;"
    end
  end
end

describe 'RbVHDL::Ast::Statement::ForGenerate' do

  context "_write_line" do

    it "_for_generate_statement('FOR_GEN', 'i', range_to(0,7))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      stmt = body._for_generate_statement('FOR_GEN', 'i', RbVHDL::Ast.range_to(0,7))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    FOR_GEN: for i in 0 to 7 generate"
      expect(line.shift).to eq "    end generate;"
      expect(line.shift).to eq "end MODEL;"
    end
  end
end
