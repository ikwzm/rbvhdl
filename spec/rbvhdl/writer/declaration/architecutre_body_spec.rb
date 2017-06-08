require "spec_helper"

describe 'RbVHDL::Ast::Declaration::ArchitectureBody' do

  context "_write_line" do

    it "" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body        = design_unit._architecture('MODEL', 'TEST')
      width_decl  = body._constant_declaration('WIDTH', 'integer'  , 8)
      valid_decl  = body._signal_declaration(  'valid', 'std_logic')
      ready_decl  = body._signal_declaration(  'ready', 'std_logic', RbVHDL::Ast.character_literal('0'))
      line        = body._write_line

      expect(line[ 0]).to eq "architecture MODEL of TEST is"
      expect(line[ 1]).to eq "    constant  WIDTH   :  integer := 8;"
      expect(line[ 2]).to eq "    signal    valid   :  std_logic;"
      expect(line[ 3]).to eq "    signal    ready   :  std_logic := '0';"
      expect(line[ 4]).to eq "begin"
      expect(line[ 5]).to eq "end     MODEL;"
    end
    
  end
  
end
