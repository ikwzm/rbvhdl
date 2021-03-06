require "spec_helper"
require "rbvhdl/writer"

describe 'RbVHDL::Ast::DesignUnit' do
  
  context "_write_line" do

    it do
      design_unit = RbVHDL::Ast::DesignUnit.new
      design_unit._horizontal_rule
      design_unit._comment("Library")
      design_unit._horizontal_rule
      design_unit._library_clause('ieee')
      design_unit._use_clause(RbVHDL::Ast.name(:ieee)._select(:numeric_std)._select_all)
      design_unit._new_line

      design_unit._horizontal_rule
      design_unit._comment("Entity")
      design_unit._horizontal_rule
      entity = design_unit._entity('sample')
      entity._generic_interface_horizontal_rule
      entity._generic_interface_comment("Generic Parameters")
      entity._generic_interface_horizontal_rule
      entity._generic_interface('WIDTH', RbVHDL::Ast.subtype_indication('integer'  )._range_to(1,8), 5)
      entity._generic_interface('SIZE' , RbVHDL::Ast.subtype_indication('integer'  ), 8)
      entity._port_interface_horizontal_rule
      entity._port_interface_comment("Clock and Reset")
      entity._port_interface_horizontal_rule
      entity._port_interface(   'CLK'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
      entity._port_interface(   'RST'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
      entity._port_interface_horizontal_rule
      entity._port_interface_comment("Input Data")
      entity._port_interface_horizontal_rule
      entity._port_interface(   'D'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :in)
      entity._port_interface_horizontal_rule
      entity._port_interface_comment("Output Data")
      entity._port_interface_horizontal_rule
      entity._port_interface(   'Q'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :out)

      line = design_unit._write_line
    
      expect(line.shift).to eq "------------------------------------------------------------------------------------"
      expect(line.shift).to eq "-- Library"
      expect(line.shift).to eq "------------------------------------------------------------------------------------"
      expect(line.shift).to eq "library ieee;"
      expect(line.shift).to eq "use     ieee.numeric_std.all;"
      expect(line.shift).to eq ""
      expect(line.shift).to eq "------------------------------------------------------------------------------------"
      expect(line.shift).to eq "-- Entity"
      expect(line.shift).to eq "------------------------------------------------------------------------------------"
      expect(line.shift).to eq "entity  sample is"
      expect(line.shift).to eq "    generic("
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        -- Generic Parameters"
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        WIDTH   :  integer range 1 to 8 := 5;"
      expect(line.shift).to eq "        SIZE    :  integer              := 8"
      expect(line.shift).to eq "    );"
      expect(line.shift).to eq "    port("
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        -- Clock and Reset"
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        CLK     :  in  std_logic;"
      expect(line.shift).to eq "        RST     :  in  std_logic;"
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        -- Input Data"
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        D       :  in  std_logic_vector(WIDTH-1 downto 0);"
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        -- Output Data"
      expect(line.shift).to eq "        ----------------------------------------------------------------------------"
      expect(line.shift).to eq "        Q       :  out std_logic_vector(WIDTH-1 downto 0)"
      expect(line.shift).to eq "    );"
      expect(line.shift).to eq "end     sample;"
    end

  end
end
