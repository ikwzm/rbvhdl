require "spec_helper"

describe 'RbVHDL::Ast::Statement::Wait' do

  context "_write_line" do

    it "_wait_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      stmt = proc._wait_statement
      
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        wait;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_wait_statement._label!('MAIN_WAIT')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      stmt = proc._wait_statement._label!('MAIN_WAIT')
      
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_WAIT: wait;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_wait_statement._on!('CLK','VALID')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      stmt = proc._wait_statement._on!('CLK','VALID')
      
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        wait on CLK, VALID;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_wait_statement._until!(...)" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      stmt = proc._wait_statement._until!(RbVHDL::Ast.logical_and(RbVHDL::Ast.name('VALID')._attribute('event'), RbVHDL::Ast.equal(RbVHDL::Ast.name('VALID'), RbVHDL::Ast.character_literal('1'))))
      
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        wait until VALID'event and VALID = '1';"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_wait_statement._for!(physical_literal(10, 'ns'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      stmt = proc._wait_statement._for!(RbVHDL::Ast.physical_literal(10, 'ns'))
      
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        wait for 10 ns;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

  end
end
