require "spec_helper"

describe 'RbVHDL::Ast::Declaration::ArchitectureBody' do

  context "_write_line" do

    it "" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body        = design_unit._architecture('MODEL', 'TEST')
      width_decl  = body._constant_declaration(   'WIDTH' , 'integer'  , 8)
      valid_decl  = body._signal_declaration(     'valid' , 'std_logic')
      ready_decl  = body._signal_declaration(     'ready' , 'std_logic', RbVHDL::Ast.character_literal('0'))
      instr_decl  = body._signal_declaration(     'instr' , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(15,0))
      alias_decl  = body._alias_declaration(      'OPCODE', nil, RbVHDL::Ast.name('instr')._downto(15,12))
      attr_decl   = body._attribute_declaration(  'attr_0', 'string')
      attr_spec   = body._attribute_specification('attr_0', 'valid', :signal, RbVHDL::Ast.string_literal("true"))
      line        = body._write_line

      expect(line[ 0]).to eq "architecture MODEL of TEST is"
      expect(line[ 1]).to eq "    constant  WIDTH   :  integer := 8;"
      expect(line[ 2]).to eq "    signal    valid   :  std_logic;"
      expect(line[ 3]).to eq "    signal    ready   :  std_logic := '0';"
      expect(line[ 4]).to eq "    signal    instr   :  std_logic_vector(15 downto 0);"
      expect(line[ 5]).to eq "    alias     OPCODE  is instr(15 downto 12);"
      expect(line[ 6]).to eq "    attribute attr_0  :  string;"
      expect(line[ 7]).to eq "    attribute attr_0  of valid : signal is \"true\";"
      expect(line[ 8]).to eq "begin"
      expect(line[ 9]).to eq "end     MODEL;"
    end
    
  end
  
end
