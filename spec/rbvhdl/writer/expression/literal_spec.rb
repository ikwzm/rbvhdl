require "spec_helper"

describe 'RbVHDL::Writer::Expression::Literal' do

  describe 'DecimalLiteral' do
    context "_write_string" do

      it do
        string = RbVHDL::Ast.numeric_expression(10)._write_string({})
        expect(string).to eq "10"
      end

      it do
        string = RbVHDL::Ast.numeric_expression(-1)._write_string({})
        expect(string).to eq "-1"
      end

      it do
        string = RbVHDL::Ast.numeric_expression(0)._fraction!(1)._write_string({})
        expect(string).to eq "0.1"
      end

      it do
        string = RbVHDL::Ast.numeric_expression(45)._exponent!(8)._write_string({})
        expect(string).to eq "45E8"
      end

      it do
        string = RbVHDL::Ast.numeric_expression(7)._exponent!(-10)._write_string({})
        expect(string).to eq "7E-10"
      end

      it do
        string = RbVHDL::Ast.numeric_expression(1)._fraction!(15)._exponent!(3, true)._write_string({})
        expect(string).to eq "1.15E+3"
      end

    end
  end

  describe 'BasedLiteral' do
    context "_write_string" do

      it do
        string = RbVHDL::Ast.based_literal(16,'AE')._write_string({})
        expect(string).to eq "16#AE#"
      end
      
      it do
        string = RbVHDL::Ast.based_literal(2,'0')._fraction!('01')._write_string({})
        expect(string).to eq "2#0.01#"
      end
      
      it do
        string = RbVHDL::Ast.based_literal(10,'1024')._exponent!(0,true)._write_string({})      
        expect(string).to eq "10#1024#E+0"
      end
      
    end
  end

  describe 'PhysicalLiteral' do
    context "_write_string" do

      it do
        string = RbVHDL::Ast.physical_literal(1000, 'ms')._write_string({})
        expect(string).to eq "1000 ms"
      end

    end
  end
  
  describe 'CharacterLiteral' do
    context "_write_string" do

      it do
        string = RbVHDL::Ast.character_literal('0')._write_string({})
        expect(string).to eq "'0'"
      end

    end
  end

  describe 'StringLiteral' do

    context "_write_string" do

      it do
        string = RbVHDL::Ast.string_literal('START')._write_string({})
        expect(string).to eq '"START"'
      end

    end
  end
  
  describe 'BitStringLiteral' do
    context "_write_string" do

      it do
        string = RbVHDL::Ast.bit_string_literal(8, :B, '1010_1110')._write_string({})
        expect(string).to eq '8B"1010_1110"'
      end
    end
  end

  describe 'NullLiteral' do
    context "_write_string" do
      it do
        string = RbVHDL::Ast.null_literal._write_string({})
        expect(string).to eq 'null'
      end
    end
  end
  
end
