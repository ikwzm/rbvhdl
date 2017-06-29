require "spec_helper"

describe 'RbVHDL::Ast::Statement::Block' do

  context "_write_line" do

    it "_block_statement('BLK')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body  = design_unit._architecture('MODEL', 'TEST')
      block = body._block_statement('BLK')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    BLK: block begin"
      expect(line.shift).to eq "    end block;"
      expect(line.shift).to eq "end MODEL;"
    end
    
    it "_block_statement('BLK')..." do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body  = design_unit._architecture('MODEL', 'TEST')
      block = body._block_statement('BLK')
      block._signal_declaration      'valid' , 'std_logic'
      block._assertion_statement(RbVHDL::Ast.equal(RbVHDL::Ast.name('valid'), RbVHDL::Ast.character_literal('0')))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    BLK: block"
      expect(line.shift).to eq "        signal    valid   :  std_logic;"
      expect(line.shift).to eq "    begin"
      expect(line.shift).to eq "        assert valid = '0';"
      expect(line.shift).to eq "    end block;"
      expect(line.shift).to eq "end MODEL;"
    end
    
  end
end
