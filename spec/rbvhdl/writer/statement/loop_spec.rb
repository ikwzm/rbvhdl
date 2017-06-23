require "spec_helper"

describe 'RbVHDL::Ast::Statement::Loop' do

  context "_write_line" do

    it "_loop_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        loop"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_loop_statement._label!('MAIN_LOOP')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_for_loop_statement('i', range_to(0,7)" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._for_loop_statement('i', RbVHDL::Ast.range_to(0,7))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        for i in 0 to 7 loop"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_for_loop_statement('i', range_to(0,7)._label!('MAIN_LOOP')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._for_loop_statement('i', RbVHDL::Ast.range_to(0,7))._label!('MAIN_LOOP')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: for i in 0 to 7 loop"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_while_loop_statement(not_equal(name('valid'), 0))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._while_loop_statement(RbVHDL::Ast.not_equal(RbVHDL::Ast.name('valid'), 0))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        while valid /= 0 loop"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_while_loop_statement(not_equal(name('valid'), 0))._label!('MAIN_LOOP')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._while_loop_statement(RbVHDL::Ast.not_equal(RbVHDL::Ast.name('valid'), 0))._label!('MAIN_LOOP')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: while valid /= 0 loop"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_exit_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._exit_statement

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            exit;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_exit_statement._label!('EXIT_LOOP')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._exit_statement._label!('EXIT_LOOP')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            EXIT_LOOP: exit;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_exit_statement._label!('EXIT_LOOP')._exit_label!('MAIN_LOOP')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._exit_statement._label!('EXIT_LOOP')._exit_label!('MAIN_LOOP')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            EXIT_LOOP: exit MAIN_LOOP;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_exit_statement._when!(equal(name('valid'), 0))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._exit_statement._when!(RbVHDL::Ast.equal(RbVHDL::Ast.name('valid'), 0))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            exit when valid = 0;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_next_statement" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._next_statement

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            next;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_next_statement._label!('NEXT_LOOP')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._next_statement._label!('NEXT_LOOP')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            NEXT_LOOP: next;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_next_statement._label!('NEXT_LOOP')._next_label!('MAIN_LOOP')" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._next_statement._label!('NEXT_LOOP')._next_label!('MAIN_LOOP')

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            NEXT_LOOP: next MAIN_LOOP;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end

    it "_next_statement._when!(equal(name('valid'), 0))" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      proc = body._process_statement
      loop = proc._loop_statement._label!('MAIN_LOOP')
      loop._next_statement._when!(RbVHDL::Ast.equal(RbVHDL::Ast.name('valid'), 0))

      line = body._write_line
      expect(line.shift).to eq "architecture MODEL of TEST is"
      expect(line.shift).to eq "begin"
      expect(line.shift).to eq "    process begin"
      expect(line.shift).to eq "        MAIN_LOOP: loop"
      expect(line.shift).to eq "            next when valid = 0;"
      expect(line.shift).to eq "        end loop;"
      expect(line.shift).to eq "    end process;"
      expect(line.shift).to eq "end     MODEL;"
    end
  end
end

