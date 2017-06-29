require "spec_helper"

describe 'RbVHDL::Ast::Statement::If' do

  context "_write_line" do

    it "if_statement(RbVHDL::Ast.name('cond_0'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      stmt = proc._if_statement(RbVHDL::Ast.name('cond_0'))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if cond_0 then"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "if_statement(RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      stmt = proc._if_statement(RbVHDL::Ast.name('cond_0'))._label!('IF_COND0')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        IF_COND0: if cond_0 then"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end
  end

  context "_elsif_statement and _else_statement" do

    it "if_statement(name('cond_0')) ... _elsif_statement(name('cond_1'))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      if_stmt = proc._if_statement(RbVHDL::Ast.name('cond_0'))
      if_stmt._null_statement
      e0_stmt = if_stmt._elsif_statement(RbVHDL::Ast.name('cond_1'))
      e0_stmt._null_statement
      
      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if    cond_0 then"
      expect(line.shift).to eq "            null;"
      expect(line.shift).to eq "        elsif cond_1 then"
      expect(line.shift).to eq "            null;"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "if_statement(name('cond_0')) ... _else_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      if_stmt = proc._if_statement(RbVHDL::Ast.name('cond_0'))
      if_stmt._null_statement
      e0_stmt = if_stmt._else_statement
      e0_stmt._null_statement

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if cond_0 then"
      expect(line.shift).to eq "            null;"
      expect(line.shift).to eq "        else"
      expect(line.shift).to eq "            null;"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end

    it "if_statement(name('cond_0')) ... _elsif_statement(name('cond_1')) ... _else_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      if_stmt = proc._if_statement(RbVHDL::Ast.name('cond_0'))
      if_stmt._null_statement
      e0_stmt = if_stmt._elsif_statement(RbVHDL::Ast.name('cond_1'))
      e0_stmt._null_statement
      e1_stmt = if_stmt._else_statement
      e1_stmt._null_statement

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        if    cond_0 then"
      expect(line.shift).to eq "            null;"
      expect(line.shift).to eq "        elsif cond_1 then"
      expect(line.shift).to eq "            null;"
      expect(line.shift).to eq "        else"
      expect(line.shift).to eq "            null;"
      expect(line.shift).to eq "        end if;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end MODEL;"
    end
  end

  
end

