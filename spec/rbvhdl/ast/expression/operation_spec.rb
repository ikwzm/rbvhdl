require "spec_helper"

describe 'RbVHDL::Ast::Expression' do

  describe "LogicalAnd" do
    context "RbVHDL::Ast.logical_and(...)" do
      it "RbVHDL::Ast.logical_and(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.logical_and(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LogicalAnd
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "LogicalNand" do
    describe "RbVHDL::Ast.logical_nand(...)" do
      it "RbVHDL::Ast.logical_nand(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.logical_nand(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LogicalNand
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "LogicalOr" do
    describe "RbVHDL::Ast.logical_or(...)" do
      it "RbVHDL::Ast.logical_or(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.logical_or(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LogicalOr
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "LogicalNor" do
    describe "RbVHDL::Ast.logical_nor(...)" do
      it "RbVHDL::Ast.logical_nor(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.logical_nor(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LogicalNor
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "LogicalXor" do
    describe "RbVHDL::Ast.logical_xor(...)" do
      it "RbVHDL::Ast.logical_xor(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.logical_xor(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LogicalXor
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "LogicalXnor" do
    describe "RbVHDL::Ast.logical_xnor(...)" do
      it "RbVHDL::Ast.logical_xnor(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.logical_xnor(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LogicalXnor
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "Equal" do
    describe "RbVHDL::Ast.equal(...)" do
      it "RbVHDL::Ast.equal(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.equal(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::Equal
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "NotEqual" do
    describe "RbVHDL::Ast.not_equal(...)" do
      it "RbVHDL::Ast.not_equal(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.not_equal(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::NotEqual
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "LessThan" do
    describe "RbVHDL::Ast.less_than(...)" do
      it "RbVHDL::Ast.less_than(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.less_than(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LessThan
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "LessThanEqual" do
    describe "RbVHDL::Ast.less_than_equal(...)" do
      it "RbVHDL::Ast.less_than_equal(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.less_than_equal(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::LessThanEqual
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "GreaterThan" do
    describe "RbVHDL::Ast.greater_than(...)" do
      it "RbVHDL::Ast.greater_than(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.greater_than(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::GreaterThan
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "GreaterThanEqual" do
    describe "RbVHDL::Ast.greater_than_equal(...)" do
      it "RbVHDL::Ast.greater_than_equal(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.greater_than_equal(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::GreaterThanEqual
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "ShiftLeftLogical" do
    describe "RbVHDL::Ast.shift_left_logical(...)" do
      it "RbVHDL::Ast.shift_left_logical(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.shift_left_logical(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ShiftLeftLogical
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "ShiftRightLogical" do
    describe "RbVHDL::Ast.shift_right_logical(...)" do
      it "RbVHDL::Ast.shift_right_logical(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.shift_right_logical(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ShiftRightLogical
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "ShiftLeftArithmetic" do
    describe "RbVHDL::Ast.shift_left_arithmetic(...)" do
      it "RbVHDL::Ast.shift_left_arithmetic(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.shift_left_arithmetic(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ShiftLeftArithmetic
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "ShiftRightArithmetic" do
    describe "RbVHDL::Ast.shift_right_arithmetic(...)" do
      it "RbVHDL::Ast.shift_right_arithmetic(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.shift_right_arithmetic(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ShiftRightArithmetic
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "RotateLeft" do
    describe "RbVHDL::Ast.rotate_left(...)" do
      it "RbVHDL::Ast.rotate_left(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.rotate_left(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::RotateLeft
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "RotateRight" do
    describe "RbVHDL::Ast.rotate_right(...)" do
      it "RbVHDL::Ast.rotate_right(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.rotate_right(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::RotateRight
        expect(expr._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer).to eq 0
        expect(expr._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer).to eq 1
      end
    end
  end

  describe "UnaryPlus" do
    describe "RbVHDL::Ast.unary_plus(...)" do
      it "RbVHDL::Ast.unary_plus(decimal_literal(10)" do
        expr = RbVHDL::Ast.unary_plus(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::UnaryPlus
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "UnaryMinus" do
    describe "RbVHDL::Ast.unary_minus(...)" do
      it "RbVHDL::Ast.unary_minus(decimal_literal(10)" do
        expr = RbVHDL::Ast.unary_minus(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::UnaryMinus
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "Addition" do
    describe "RbVHDL::Ast.addition(...)" do
      it "RbVHDL::Ast.addition(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.addition(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 0
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 1
      end
      it "RbVHDL::Ast.addition(unary_minus(decimal_literal(1)),decimal_literal(2))" do
        expr = RbVHDL::Ast.addition(RbVHDL::Ast.unary_minus(RbVHDL::Ast.decimal_literal(1)),RbVHDL::Ast.decimal_literal(2))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::UnaryMinus
        expect(expr._l_expr._expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._expr._integer).to eq 1
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 2
      end
    end
  end
  

  describe "Subtraction" do
    describe "RbVHDL::Ast.subtraction(...)" do
      it "RbVHDL::Ast.subtraction(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.subtraction(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 0
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 1
      end
      it "RbVHDL::Ast.subtraction(unary_plus(decimal_literal(1)),decimal_literal(2))" do
        expr = RbVHDL::Ast.subtraction(RbVHDL::Ast.unary_plus(RbVHDL::Ast.decimal_literal(1)),RbVHDL::Ast.decimal_literal(2))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::UnaryPlus
        expect(expr._l_expr._expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._expr._integer).to eq 1
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 2
      end
    end
  end
  
  describe "Concatenation" do
    describe "RbVHDL::Ast.concatenation(...)" do
      it "RbVHDL::Ast.concatenation(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.concatenation(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 0
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 1
      end
      it "RbVHDL::Ast.concatenation(unary_plus(decimal_literal(1)),decimal_literal(2))" do
        expr = RbVHDL::Ast.concatenation(RbVHDL::Ast.unary_plus(RbVHDL::Ast.decimal_literal(1)),RbVHDL::Ast.decimal_literal(2))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::UnaryPlus
        expect(expr._l_expr._expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._expr._integer).to eq 1
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 2
      end
    end
  end
  
  describe "Multiplication" do
    describe "RbVHDL::Ast.multiplication(...)" do
      it "RbVHDL::Ast.multiplication(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.multiplication(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Multiplication
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 0
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 1
      end
    end
  end
  
  describe "Division" do
    describe "RbVHDL::Ast.division(...)" do
      it "RbVHDL::Ast.division(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.division(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Division
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 0
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 1
      end
    end
  end
  
  describe "Modulo" do
    describe "RbVHDL::Ast.modulo(...)" do
      it "RbVHDL::Ast.modulo(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.modulo(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Modulo
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 0
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 1
      end
    end
  end
  
  describe "Remainder" do
    describe "RbVHDL::Ast.remainder(...)" do
      it "RbVHDL::Ast.remainder(decimal_literal(0),decimal_literal(1))" do
        expr = RbVHDL::Ast.remainder(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(1))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Remainder
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 0
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 1
      end
    end
  end
  
  describe "Exponentiation" do
    describe "RbVHDL::Ast.exponentiation(...)" do
      it "RbVHDL::Ast.exponentiation(decimal_literal(2),decimal_literal(3))" do
        expr = RbVHDL::Ast.exponentiation(RbVHDL::Ast.decimal_literal(2),RbVHDL::Ast.decimal_literal(3))
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::Exponentiation
        expect(expr._l_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._l_expr._integer      ).to eq 2
        expect(expr._r_expr.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._r_expr._integer      ).to eq 3
      end
    end
  end
  
  describe "Abs" do
    describe "RbVHDL::Ast.abs(...)" do
      it "RbVHDL::Ast.abs(decimal_literal(10)" do
        expr = RbVHDL::Ast.abs(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::Abs
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "Not" do
    describe "RbVHDL::Ast.not(...)" do
      it "RbVHDL::Ast.not(decimal_literal(10)" do
        expr = RbVHDL::Ast.not(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::Not
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "ReductionAnd" do
    describe "RbVHDL::Ast.reduction_and(...)" do
      it "RbVHDL::Ast.reduction_and(decimal_literal(10)" do
        expr = RbVHDL::Ast.reduction_and(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ReductionAnd
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "ReductionNand" do
    describe "RbVHDL::Ast.reduction_nand(...)" do
      it "RbVHDL::Ast.reduction_nand(decimal_literal(10)" do
        expr = RbVHDL::Ast.reduction_nand(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ReductionNand
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "ReductionOr" do
    describe "RbVHDL::Ast.reduction_or(...)" do
      it "RbVHDL::Ast.reduction_or(decimal_literal(10)" do
        expr = RbVHDL::Ast.reduction_or(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ReductionOr
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "ReductionNor" do
    describe "RbVHDL::Ast.reduction_nor(...)" do
      it "RbVHDL::Ast.reduction_nor(decimal_literal(10)" do
        expr = RbVHDL::Ast.reduction_nor(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ReductionNor
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "ReductionXor" do
    describe "RbVHDL::Ast.reduction_xor(...)" do
      it "RbVHDL::Ast.reduction_xor(decimal_literal(10)" do
        expr = RbVHDL::Ast.reduction_xor(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ReductionXor
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

  describe "ReductionXnor" do
    describe "RbVHDL::Ast.reduction_xnor(...)" do
      it "RbVHDL::Ast.reduction_xnor(decimal_literal(10)" do
        expr = RbVHDL::Ast.reduction_xnor(RbVHDL::Ast.decimal_literal(10))
        expect(expr.class           ).to eq RbVHDL::Ast::Expression::ReductionXnor
        expect(expr._expr.class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._integer  ).to eq 10
      end
    end
  end

end

