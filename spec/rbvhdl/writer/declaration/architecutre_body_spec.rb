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
      comp_decl   = body._component_declaration(  'SUB_0')
      comp_decl._generic_interface('WIDTH', RbVHDL::Ast.subtype_indication('integer'  )._range_to(1,8), 5)
      comp_decl._generic_interface('SIZE' , RbVHDL::Ast.subtype_indication('integer'  ), 8)
      comp_decl._port_interface(   'CLK'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
      comp_decl._port_interface(   'RST'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
      comp_decl._port_interface(   'D'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :in)
      comp_decl._port_interface(   'Q'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :out)
      line        = body._write_line

      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "    constant  WIDTH   :  integer := 8;"
      expect(line.shift).to eq "    signal    valid   :  std_logic;"
      expect(line.shift).to eq "    signal    ready   :  std_logic := '0';"
      expect(line.shift).to eq "    signal    instr   :  std_logic_vector(15 downto 0);"
      expect(line.shift).to eq "    alias     OPCODE  is instr(15 downto 12);"
      expect(line.shift).to eq "    attribute attr_0  :  string;"
      expect(line.shift).to eq "    attribute attr_0  of valid : signal is \"true\";"
      expect(line.shift).to eq "    component SUB_0 is"
      expect(line.shift).to eq "        generic("
      expect(line.shift).to eq "              WIDTH   :  integer range 1 to 8 := 5;"
      expect(line.shift).to eq "              SIZE    :  integer              := 8"
      expect(line.shift).to eq "        );"
      expect(line.shift).to eq "        port("
      expect(line.shift).to eq "              CLK     :  in  std_logic;"
      expect(line.shift).to eq "              RST     :  in  std_logic;"
      expect(line.shift).to eq "              D       :  in  std_logic_vector(WIDTH-1 downto 0);"
      expect(line.shift).to eq "              Q       :  out std_logic_vector(WIDTH-1 downto 0)"
      expect(line.shift).to eq "        );"
      expect(line.shift).to eq "    end component;"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "end     MODEL;"
    end
    
  end
  
end
