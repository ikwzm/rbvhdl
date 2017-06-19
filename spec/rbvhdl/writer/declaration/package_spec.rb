require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Package' do

  context "_write_line" do

    it do
      design_unit = RbVHDL::Ast::DesignUnit.new
      package     = design_unit._package('TEST')
      package._constant_declaration(   'DATA_WIDTH', 'integer'  , 8)

      package._record_type_declaration('DATA_TYPE')
        ._field!('DATA' , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:DATA_WIDTH),1),0))
        ._field!('STRB' , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(8,1), 0))
        ._field!('VALID', 'boolean')

      package._physical_type_declaration('resistance', RbVHDL::Ast.range_to(0, 1e15), 'ohm')
        ._unit!('kohm', 1000, 'ohm' )
        ._unit!('Mohm', 1000, 'kohm')

      package._enumeration_type_declaration('logic_level')
        ._enum!('unknown')
        ._enum!('low')
        ._enum!('undriven')
        ._enum!('high')

      package._integer_type_declaration('year', RbVHDL::Ast.range_to(0, 2100))

      package._floating_type_declaration('input_level', RbVHDL::Ast.range_to(-10.0, 10.0))

      proc = package._procedure_declaration('PROC')
      proc._parameter_file_interface(    'INPUT_FILE' , 'integer')
      proc._parameter_interface(         'PARAM0'     , 'integer'         , :In )
      proc._parameter_constant_interface('PARAM1'     , 'integer'         , :In )
      proc._parameter_signal_interface(  'I_DATA'     , 'std_logic_vector', :In )
      proc._parameter_signal_interface(  'O_DATA'     , 'std_logic_vector', :out)

      func = package._function_declaration('FUNC', 'std_logic_vector')
      func._parameter_interface(         'PARAM0'     , 'integer'         )
      func._parameter_interface(         'PARAM1'     , 'integer'         )
      func._parameter_interface(         'I_DATA'     , 'std_logic_vector')

      line        = package._write_line

      expect(line.shift).to eq "package TEST is"
      expect(line.shift).to eq "    constant  DATA_WIDTH      :  integer := 8;"
      expect(line.shift).to eq "    type      DATA_TYPE       is record"
      expect(line.shift).to eq "              DATA            :  std_logic_vector(DATA_WIDTH-1 downto 0);"
      expect(line.shift).to eq "              STRB            :  std_logic_vector(8-1 downto 0);"
      expect(line.shift).to eq "              VALID           :  boolean;"
      expect(line.shift).to eq "    end record;"
      expect(line.shift).to eq "    type      resistance      is range 0 to 1.0E+15 units"
      expect(line.shift).to eq "              ohm;"
      expect(line.shift).to eq "              kohm = 1000 ohm;"
      expect(line.shift).to eq "              Mohm = 1000 kohm;"
      expect(line.shift).to eq "    end units;"
      expect(line.shift).to eq "    type      logic_level     is (unknown, low, undriven, high);"
      expect(line.shift).to eq "    type      year            is range 0 to 2100;"
      expect(line.shift).to eq "    type      input_level     is range -10.0 to 10.0;"
      expect(line.shift).to eq "    procedure PROC("
      expect(line.shift).to eq "        file      INPUT_FILE      :      integer;"
      expect(line.shift).to eq "                  PARAM0          :  in  integer;"
      expect(line.shift).to eq "        constant  PARAM1          :  in  integer;"
      expect(line.shift).to eq "        signal    I_DATA          :  in  std_logic_vector;"
      expect(line.shift).to eq "        signal    O_DATA          :  out std_logic_vector"
      expect(line.shift).to eq "    );"
      expect(line.shift).to eq "    function  FUNC("
      expect(line.shift).to eq "                  PARAM0  :  integer;"
      expect(line.shift).to eq "                  PARAM1  :  integer;"
      expect(line.shift).to eq "                  I_DATA  :  std_logic_vector"
      expect(line.shift).to eq "    )             return     std_logic_vector;"
      expect(line.shift).to eq "end TEST;"
    end
  end
end
