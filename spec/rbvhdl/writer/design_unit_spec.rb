require "spec_helper"
require "rbvhdl/writer"

describe 'RbVHDL::Ast::DesignUnit' do
  
  context "_write_line" do

    design_unit = RbVHDL::Ast::DesignUnit.new
    design_unit._library_clause('ieee')
    design_unit._use_clause(RbVHDL::Ast.name(:ieee)._select(:numeric_std)._select_all)
    lines = design_unit._write_line
    
    it "_library_clause._write_line" do
      expect(lines[0]).to eq "library ieee;"
    end

    it "_use_clause._write_line" do
      expect(lines[1]).to eq "use     ieee.numeric_std.all;"
    end

  end
end
