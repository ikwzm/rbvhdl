require "spec_helper"

describe 'RbVHDL::Ast::Declaration::PackageBody' do

  context "_write_line" do

    it do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body       = design_unit._package_body('TEST')
      width_decl = body._constant_declaration(   'WIDTH' , 'integer'  , 8)
      line       = body._write_line

      expect(line.shift).to eq "package body TEST is"
      expect(line.shift).to eq "    constant  WIDTH   :  integer := 8;"
      expect(line.shift).to eq "end TEST;"
    end
  end
end
