require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Entity' do

  context "_write_line" do

    it  do
      entity = RbVHDL::Ast.entity_declaration(nil, 'sample')
      entity._generic_interface('WIDTH', RbVHDL::Ast.subtype_indication('integer'  )._range_to(1,8), 5)
      entity._generic_interface('SIZE' , RbVHDL::Ast.subtype_indication('integer'  ), 8)
      entity._port_interface(   'CLK'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
      entity._port_interface(   'RST'  , RbVHDL::Ast.subtype_indication('std_logic'), :in)
      entity._port_interface(   'D'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :in)
      entity._port_interface(   'Q'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name(:WIDTH),1),0), :out)
      line = entity._write_line
      expect(line[ 0]).to eq "entity  sample is"
      expect(line[ 1]).to eq "    generic("
      expect(line[ 2]).to eq "        WIDTH    :  integer range 1 to 8 := 5;"
      expect(line[ 3]).to eq "        SIZE     :  integer              := 8"
      expect(line[ 4]).to eq "    );"
      expect(line[ 5]).to eq "    port("
      expect(line[ 6]).to eq "        CLK      :  in  std_logic;"
      expect(line[ 7]).to eq "        RST      :  in  std_logic;"
      expect(line[ 8]).to eq "        D        :  in  std_logic_vector(WIDTH-1 downto 0);"
      expect(line[ 9]).to eq "        Q        :  out std_logic_vector(WIDTH-1 downto 0)"
      expect(line[10]).to eq "    );"
      expect(line[11]).to eq "end     sample;"
    end
  end

end
