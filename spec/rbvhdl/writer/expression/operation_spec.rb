require "spec_helper"

describe 'RbVHDL::Ast::Expression' do

  describe "LogicalAnd" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.logical_and(0, 1)
        string = expr._write_string({})
        expect(string).to eq "0 and 1"
      end
      it do
        expr = RbVHDL::Ast.logical_and(0, 1, 2)
        string = expr._write_string({})
        expect(string).to eq "0 and 1 and 2"
      end
      it do
        expr = RbVHDL::Ast.logical_and(RbVHDL::Ast.logical_and(0, 1), 2)
        string = expr._write_string({})
        expect(string).to eq "0 and 1 and 2"
      end
    end
  end

  describe "LogicalNand" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.logical_nand(0, 1)
        string = expr._write_string({})
        expect(string).to eq "0 nand 1"
      end
    end
  end
  
  describe "LogicalOr" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.logical_or(0, 1)
        string = expr._write_string({})
        expect(string).to eq "0 or 1"
      end
      it do
        expr = RbVHDL::Ast.logical_or(0, 1, 2)
        string = expr._write_string({})
        expect(string).to eq "0 or 1 or 2"
      end
      it do
        expr = RbVHDL::Ast.logical_or(RbVHDL::Ast.logical_or(0, 1), 2)
        string = expr._write_string({})
        expect(string).to eq "0 or 1 or 2"
      end
    end
  end
        
  describe "LogicalNor" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.logical_nor(0, 1)
        string = expr._write_string({})
        expect(string).to eq "0 nor 1"
      end
    end
  end

  describe "LogicalXor" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.logical_xor(0, 1)
        string = expr._write_string({})
        expect(string).to eq "0 xor 1"
      end
      it do
        expr = RbVHDL::Ast.logical_xor(0, 1, 2)
        string = expr._write_string({})
        expect(string).to eq "0 xor 1 xor 2"
      end
      it do
        expr = RbVHDL::Ast.logical_xor(RbVHDL::Ast.logical_xor(0, 1), 2)
        string = expr._write_string({})
        expect(string).to eq "0 xor 1 xor 2"
      end
    end
  end

  describe "LogicalXnor" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.logical_xnor(0, 1)
        string = expr._write_string({})
        expect(string).to eq "0 xnor 1"
      end
      it do
        expr = RbVHDL::Ast.logical_xnor(0, 1, 2)
        string = expr._write_string({})
        expect(string).to eq "0 xnor 1 xnor 2"
      end
      it do
        expr = RbVHDL::Ast.logical_xnor(RbVHDL::Ast.logical_xnor(0, 1), 2)
        string = expr._write_string({})
        expect(string).to eq "0 xnor 1 xnor 2"
      end
    end
  end

  describe "Equal" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.equal(RbVHDL::Ast.name('valid'), RbVHDL::Ast.character_literal('1'))
        string = expr._write_string({})
        expect(string).to eq "valid = '1'"
      end
    end
  end
        
  describe "NotEqual" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.not_equal(RbVHDL::Ast.name('valid'), RbVHDL::Ast.character_literal('1'))
        string = expr._write_string({})
        expect(string).to eq "valid /= '1'"
      end
    end
  end
    
  describe "LessThan" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.less_than(RbVHDL::Ast.name('count'), 1)
        string = expr._write_string({})
        expect(string).to eq "count < 1"
      end
    end
  end

  describe "LessThanEqual" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.less_than_equal(RbVHDL::Ast.name('count'), 1)
        string = expr._write_string({})
        expect(string).to eq "count <= 1"
      end
    end
  end

  describe "GreaterThan" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.greater_than(RbVHDL::Ast.name('count'), 1)
        string = expr._write_string({})
        expect(string).to eq "count > 1"
      end
    end
  end

  describe "GreaterThanEqual" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.greater_than_equal(RbVHDL::Ast.name('count'), 1)
        string = expr._write_string({})
        expect(string).to eq "count >= 1"
      end
    end
  end
  
  describe "ShiftLeftLogical" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.shift_left_logical(RbVHDL::Ast.name('data'), 8)
        string = expr._write_string({})
        expect(string).to eq "data sll 8"
      end
    end
  end
  
  describe "ShiftRightLogical" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.shift_right_logical(RbVHDL::Ast.name('data'), 8)
        string = expr._write_string({})
        expect(string).to eq "data srl 8"
      end
    end
  end
    
  describe "ShiftLeftArithmetic" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.shift_left_arithmetic(RbVHDL::Ast.name('data'), 8)
        string = expr._write_string({})
        expect(string).to eq "data sla 8"
      end
    end
  end

  describe "ShiftRightArithmetic" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.shift_right_arithmetic(RbVHDL::Ast.name('data'), 8)
        string = expr._write_string({})
        expect(string).to eq "data sra 8"
      end
    end
  end
  
  describe "RotateLeft" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.rotate_left(RbVHDL::Ast.name('data'), 8)
        string = expr._write_string({})
        expect(string).to eq "data rol 8"
      end
    end
  end

  describe "RotateRight" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.rotate_right(RbVHDL::Ast.name('data'), 8)
        string = expr._write_string({})
        expect(string).to eq "data ror 8"
      end
    end
  end

  describe "UnaryPlus" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.unary_plus(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "+data"
      end
      it do
        expr = RbVHDL::Ast.unary_plus(10)
        string = expr._write_string({})
        expect(string).to eq "+10"
      end
    end
  end

  describe "UnaryMinus" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.unary_minus(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "-data"
      end
      it do
        expr = RbVHDL::Ast.unary_minus(10)
        string = expr._write_string({})
        expect(string).to eq "-10"
      end
    end
  end
  
  describe "Addition" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.addition(3, 5)
        string = expr._write_string({})
        expect(string).to eq "3+5"
      end
      it do
        expr = RbVHDL::Ast.addition(3, 5, 8)
        string = expr._write_string({})
        expect(string).to eq "3+5+8"
      end
      it do
        expr = RbVHDL::Ast.addition(RbVHDL::Ast.subtraction(0, 1), 2)
        string = expr._write_string({})
        expect(string).to eq "0-1+2"
      end
      it do
        expr = RbVHDL::Ast.addition(RbVHDL::Ast.unary_minus(1), 2)
        string = expr._write_string({})
        expect(string).to eq "-1+2"
      end
    end
  end

  describe "Subtraction" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.subtraction(3, 5)
        string = expr._write_string({})
        expect(string).to eq "3-5"
      end
      it do
        expr = RbVHDL::Ast.subtraction(3, 5, 8)
        string = expr._write_string({})
        expect(string).to eq "3-5-8"
      end
      it do
        expr = RbVHDL::Ast.subtraction(RbVHDL::Ast.subtraction(0, 1), 2)
        string = expr._write_string({})
        expect(string).to eq "0-1-2"
      end
      it do
        expr = RbVHDL::Ast.subtraction(RbVHDL::Ast.unary_minus(1), 2)
        string = expr._write_string({})
        expect(string).to eq "-1-2"
      end
    end
  end
    
  describe "Concatenation" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.concatenation(RbVHDL::Ast.string_literal('INFO:'), RbVHDL::Ast.string_literal('1111'))
        string = expr._write_string({})
        expect(string).to eq '"INFO:" & "1111"'
      end
      it do
        expr = RbVHDL::Ast.concatenation(RbVHDL::Ast.string_literal('INFO:'), RbVHDL::Ast.string_literal('1111'), RbVHDL::Ast.string_literal('0'))
        string = expr._write_string({})
        expect(string).to eq '"INFO:" & "1111" & "0"'
      end
      it do
        expr = RbVHDL::Ast.concatenation(RbVHDL::Ast.concatenation(RbVHDL::Ast.string_literal('INFO:'), RbVHDL::Ast.string_literal('1111')), RbVHDL::Ast.string_literal('0'))
        string = expr._write_string({})
        expect(string).to eq '"INFO:" & "1111" & "0"'
      end
    end
  end

  describe "Multiplication" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.multiplication(2, 3)
        string = expr._write_string({})
        expect(string).to eq "2*3"
      end
      it do
        expr = RbVHDL::Ast.multiplication(2, 3, 4)
        string = expr._write_string({})
        expect(string).to eq "2*3*4"
      end
      it do
        expr = RbVHDL::Ast.multiplication(RbVHDL::Ast.multiplication(2, 3), 4)
        string = expr._write_string({})
        expect(string).to eq "2*3*4"
      end
      it do
        expr = RbVHDL::Ast.multiplication(2, RbVHDL::Ast.multiplication(3, 4))
        string = expr._write_string({})
        expect(string).to eq "2*3*4"
      end
    end
  end
  
  describe "Division" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.division(5, 8)
        string = expr._write_string({})
        expect(string).to eq "5/8"
      end
      it do
        expr = RbVHDL::Ast.division(5, 8, 2)
        string = expr._write_string({})
        expect(string).to eq "5/8/2"
      end
      it do
        expr = RbVHDL::Ast.division(RbVHDL::Ast.division(5, 8), 2)
        string = expr._write_string({})
        expect(string).to eq "5/8/2"
      end
      it do
        expr = RbVHDL::Ast.division(5, RbVHDL::Ast.division(8, 2))
        string = expr._write_string({})
        expect(string).to eq "5/8/2"
      end
    end
  end

  describe "Modulo" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.modulo(7, 4)
        string = expr._write_string({})
        expect(string).to eq "7 mod 4"
      end
    end
  end

  describe "Remainder" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.remainder(9, 8)
        string = expr._write_string({})
        expect(string).to eq "9 rem 8"
      end
    end
  end

  describe "Exponentiation" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.exponentiation(2, 3)
        string = expr._write_string({})
        expect(string).to eq "2**3"
      end
    end
  end
    
  describe "Abs" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.abs(10)
        string = expr._write_string({})
        expect(string).to eq "abs 10"
      end
    end
  end

  describe "Not" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.not(RbVHDL::Ast.parenthesized_expression(RbVHDL::Ast.equal(RbVHDL::Ast.name('valid'), RbVHDL::Ast.character_literal('1'))))
        string = expr._write_string({})
        expect(string).to eq "not (valid = '1')"
      end
    end
  end
    
  describe "ReductionAnd" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.reduction_and(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "and data"
      end
    end
  end
    
  describe "ReductionNand" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.reduction_nand(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "nand data"
      end
    end
  end

  describe "ReductionOr" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.reduction_or(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "or data"
      end
    end
  end
    
  describe "ReductionNor" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.reduction_nor(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "nor data"
      end
    end
  end

  describe "ReductionXor" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.reduction_xor(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "xor data"
      end
    end
  end
    
  describe "ReductionXnor" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.reduction_xnor(RbVHDL::Ast.name('data'))
        string = expr._write_string({})
        expect(string).to eq "xnor data"
      end
    end
  end

  describe "ParenthesizedExpression" do
    context "_write_string" do
      it do
        expr = RbVHDL::Ast.parenthesized_expression(RbVHDL::Ast.logical_and(0, 1))
        string = expr._write_string({})
        expect(string).to eq "(0 and 1)"
      end
      it do
        expr = RbVHDL::Ast.subtraction(RbVHDL::Ast.multiplication(8, RbVHDL::Ast.parenthesized_expression(RbVHDL::Ast.addition(RbVHDL::Ast.name('i'), 1))), 1)
        string = expr._write_string({})
        expect(string).to eq "8*(i+1)-1"
      end
    end
  end
    
end
