require "spec_helper"

describe 'RbVHDL::Ast::Declaration::ArchitectureBody' do

  context "_write_line" do

    it do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body        = design_unit._architecture('MODEL', 'TEST')
      itype_decl  = body._subtype_declaration     'I_TYPE', RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(31,0)
      width_decl  = body._constant_declaration    'WIDTH' , 'integer'  , 8
      valid_decl  = body._signal_declaration      'valid' , 'std_logic'
      ready_decl  = body._signal_declaration      'ready' , 'std_logic', RbVHDL::Ast.character_literal('0')
      instr_decl  = body._signal_declaration      'instr' , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(15,0)
      alias_decl  = body._alias_declaration       'OPCODE', nil, RbVHDL::Ast.name('instr')._downto(15,12)
      attr_decl   = body._attribute_declaration   'attr_0', 'string'
      attr_spec   = body._attribute_specification 'attr_0', 'valid', :signal, RbVHDL::Ast.string_literal("true")
      comp_decl   = body._component_declaration   'SUB_0'
      comp_decl._generic_interface 'WIDTH', RbVHDL::Ast.subtype_indication('integer'  )._range_to(1,8), 5
      comp_decl._generic_interface 'SIZE' , RbVHDL::Ast.subtype_indication('integer'  ), 8
      comp_decl._port_interface    'CLK'  , RbVHDL::Ast.subtype_indication('std_logic'), :in
      comp_decl._port_interface    'RST'  , RbVHDL::Ast.subtype_indication('std_logic'), :in
      comp_decl._port_interface    'D'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :in
      comp_decl._port_interface    'Q'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :out

      proc_decl  = body._procedure_body('PROC')
      proc_decl._parameter_interface  'PARAM0', 'integer'         , :in, 8
      proc_decl._parameter_interface  'D'     , 'std_logic_vector', :in
      proc_decl._parameter_interface  'Q'     , 'std_logic_vector', :out
      proc_decl._alias_declaration    'i_data', RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:PARAM0),1), 0), 'D'
      proc_decl._variable_declaration 'q_data', RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:PARAM0),1), 0)
      proc_loop1 = proc_decl._loop_statement
      proc_loop1._label!('LOOP1')
      proc_loop1._exit_statement._label!('EXIT_LOOP1')._exit_label!('LOOP1')
      proc_loop1._next_statement._label!('NEXT_LOOP1')._next_label!('LOOP1')
      proc_loop2 = proc_decl._for_loop_statement('i', RbVHDL::Ast.name('q_data')._attribute('range'))
      proc_loop2._label!('LOOP2')
      proc_loop2._exit_statement._label!('EXIT_LOOP2')._exit_label!('LOOP2')._when!(RbVHDL::Ast.not_equal(RbVHDL::Ast.name('i'), 0))
      proc_loop2._next_statement._label!('NEXT_LOOP2')._next_label!('LOOP2')._when!(RbVHDL::Ast.not_equal(RbVHDL::Ast.name('i'), 1))
      proc_loop3 = proc_decl._while_loop_statement(RbVHDL::Ast.not_equal(RbVHDL::Ast.name('i_data'), 0))
      proc_loop3._label!('LOOP3')
      
      comp_stmt  = body._component_instantiation_statement('U_0', 'SUB_0')
      comp_stmt._generic_association 'WIDTH', 32
      comp_stmt._generic_association 'SIZE' , 15
      comp_stmt._port_association    'CLK'  , 'CLK'
      comp_stmt._port_association    'RST'  , 'RST'
      comp_stmt._port_association    'D'    , 'i_data'
      comp_stmt._port_association    'Q'    , 'q_data'

      proc_stmt  = body._procedure_call('PROC')
      proc_stmt._label!('P_0')
      proc_stmt._parameter_association 'PARAM0', RbVHDL::Ast.name('q_data')._attribute('range')
      proc_stmt._parameter_association 'D'     , RbVHDL::Ast.name('i_data')
      proc_stmt._parameter_association 'Q'     , RbVHDL::Ast.name('q_data')

      line        = body._write_line

      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "    subtype   I_TYPE  is std_logic_vector(31 downto 0);"
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
      expect(line.shift).to eq "    procedure PROC("
      expect(line.shift).to eq "                  PARAM0  :  in  integer          := 8;"
      expect(line.shift).to eq "                  D       :  in  std_logic_vector;"
      expect(line.shift).to eq "                  Q       :  out std_logic_vector"
      expect(line.shift).to eq "    ) is"
      expect(line.shift).to eq "        alias     i_data  :  std_logic_vector(PARAM0-1 downto 0) is D;"
      expect(line.shift).to eq "        variable  q_data  :  std_logic_vector(PARAM0-1 downto 0);"
      expect(line.shift).to eq "    begin"
      expect(line.shift).to eq "        LOOP1: loop"
      expect(line.shift).to eq "            EXIT_LOOP1: exit LOOP1;"
      expect(line.shift).to eq "            NEXT_LOOP1: next LOOP1;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "        LOOP2: for i in q_data'range loop"
      expect(line.shift).to eq "            EXIT_LOOP2: exit LOOP2 when i /= 0;"
      expect(line.shift).to eq "            NEXT_LOOP2: next LOOP2 when i /= 1;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "        LOOP3: while i_data /= 0 loop"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end procedure;"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    U_0: SUB_0"
      expect(line.shift).to eq "        generic map("
      expect(line.shift).to eq "            WIDTH   => 32      ,"
      expect(line.shift).to eq "            SIZE    => 15      "
      expect(line.shift).to eq "        )"
      expect(line.shift).to eq "        port map("
      expect(line.shift).to eq "            CLK     => CLK     ,"
      expect(line.shift).to eq "            RST     => RST     ,"
      expect(line.shift).to eq "            D       => i_data  ,"
      expect(line.shift).to eq "            Q       => q_data  "
      expect(line.shift).to eq "        );"
      expect(line.shift).to eq "    P_0: PROC("
      expect(line.shift).to eq "            PARAM0  => q_data'range    ,"
      expect(line.shift).to eq "            D       => i_data          ,"
      expect(line.shift).to eq "            Q       => q_data          "
      expect(line.shift).to eq "    );"
      expect(line.shift).to eq "end MODEL;"
    end
    
  end
  
end
