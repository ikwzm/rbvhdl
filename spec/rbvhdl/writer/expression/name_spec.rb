require "spec_helper"

describe 'RbVHDL::Writer::Expression::Name' do

  describe 'SimpleName' do
    context "_write_string" do
      it do
        string = RbVHDL::Ast.name('simple_name_0')._write_string({})
        expect(string).to eq "simple_name_0"
      end
    end
  end

  describe 'IndexedName' do
    context "_write_string" do
      it do
        string = RbVHDL::Ast.name('indexed_name_0')._index(RbVHDL::Ast.name('i'))._write_string({})
        expect(string).to eq "indexed_name_0(i)"
      end
      it do
        string = RbVHDL::Ast.name('indexed_name_1')._index([RbVHDL::Ast.name('i'), RbVHDL::Ast.name('j')])._write_string({})
        expect(string).to eq "indexed_name_1(i, j)"
      end
      it do
        string = RbVHDL::Ast.name('indexed_name_2')._index(RbVHDL::Ast.name('i'))._index(RbVHDL::Ast.name('j'))._write_string({})
        expect(string).to eq "indexed_name_2(i)(j)"
      end
    end
  end
  
  describe 'SliceName' do
    context "_write_string" do
      it do
        string = RbVHDL::Ast.name('slice_name_0')._slice(RbVHDL::Ast.range_attr(RbVHDL::Ast.name('slice_type')._attribute('range')))._write_string({})
        expect(string).to eq "slice_name_0(slice_type'range)"
      end
      it do
        string = RbVHDL::Ast.name('slice_name_1')._to(0, 5)._write_string({})
        expect(string).to eq "slice_name_1(0 to 5)"
      end
      it do
        string = RbVHDL::Ast.name('slice_name_2')._downto(7, 4)._write_string({})
        expect(string).to eq "slice_name_2(7 downto 4)"
      end
    end
  end
    
  describe 'SelectedName' do
    context "_write_string" do
      it do
        string = RbVHDL::Ast.name('library_name')._select('package_name')._write_string({})
        expect(string).to eq "library_name.package_name"
      end
      it do
        string = RbVHDL::Ast.name('library_name')._select('package_name')._select('component_name')._write_string({})
        expect(string).to eq "library_name.package_name.component_name"
      end
      it do
        string = RbVHDL::Ast.name('library_name')._select('package_name')._select_all._write_string({})
        expect(string).to eq "library_name.package_name.all"
      end
    end
  end
    
  describe 'FunctionCall' do
    context "_write_string" do
      it do
        string = RbVHDL::Ast.name('function_0')._call([])._write_string({})
        expect(string).to eq "function_0"
      end
      it do
        string = RbVHDL::Ast.name('function_1')._call(RbVHDL::Ast.name(:param0))._write_string({})
        expect(string).to eq "function_1(param0)"
      end
      it do
        string = RbVHDL::Ast.name('function_2')._call([RbVHDL::Ast.name(:param0), RbVHDL::Ast.name(:param1)])._write_string({})
        expect(string).to eq "function_2(param0, param1)"
      end
      it do
        string = RbVHDL::Ast.name('function_3')._call({RbVHDL::Ast.name(:arg0) => RbVHDL::Ast.name(:param0), RbVHDL::Ast.name(:arg1) => RbVHDL::Ast.name(:param1)})._write_string({})
        expect(string).to eq "function_3(arg0 => param0, arg1 => param1)"
      end
      it do
        name = RbVHDL::Ast.name('function_4')._call([])
        name._parameter_association('arg0', 0)
        name._parameter_association('arg1', 1)
        string = name._write_string({})
        expect(string).to eq "function_4(arg0 => 0, arg1 => 1)"
      end
    end
  end
    
  describe 'AttributeName' do
    context "_write_string" do
      it do
        string = RbVHDL::Ast.name('signal_1')._attribute('range')._write_string({})
        expect(string).to eq "signal_1'range"
      end
    end
  end
    
end
