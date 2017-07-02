require "spec_helper"

describe 'RbVHDL::Ast::Expression' do

  describe "LogicalAnd" do
    context "RbVHDL::Ast.logical_and(...)" do
      it "RbVHDL::Ast.logical_and(0, 1)" do
        expr = RbVHDL::Ast.logical_and(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalAnd
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.logical_and(0, 1, 2)" do
        expr = RbVHDL::Ast.logical_and(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalAnd
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalAnd
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.logical_and(logical_and(0, 1), 2)" do
        expr = RbVHDL::Ast.logical_and(RbVHDL::Ast.logical_and(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalAnd
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalAnd
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end

  describe "LogicalNand" do
    describe "RbVHDL::Ast.logical_nand(...)" do
      it "RbVHDL::Ast.logical_nand(0, 1)" do
        expr = RbVHDL::Ast.logical_nand(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::LogicalNand
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "LogicalOr" do
    describe "RbVHDL::Ast.logical_or(...)" do
      it "RbVHDL::Ast.logical_or(0, 1)" do
        expr = RbVHDL::Ast.logical_or(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalOr
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.logical_or(0, 1, 2)" do
        expr = RbVHDL::Ast.logical_or(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalOr
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalOr
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.logical_or(logical_or(0, 1), 2)" do
        expr = RbVHDL::Ast.logical_or(RbVHDL::Ast.logical_or(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalOr
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalOr
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end

  describe "LogicalNor" do
    describe "RbVHDL::Ast.logical_nor(...)" do
      it "RbVHDL::Ast.logical_nor(0, 1)" do
        expr = RbVHDL::Ast.logical_nor(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalNor
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
    end
  end

  describe "LogicalXor" do
    describe "RbVHDL::Ast.logical_xor(...)" do
      it "RbVHDL::Ast.logical_xor(0, 1)" do
        expr = RbVHDL::Ast.logical_xor(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalXor
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.logical_xor(0, 1, 2)" do
        expr = RbVHDL::Ast.logical_xor(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalXor
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalXor
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.logical_xor(logical_xor(0, 1), 2)" do
        expr = RbVHDL::Ast.logical_xor(RbVHDL::Ast.logical_xor(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalXor
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalXor
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end

  describe "LogicalXnor" do
    describe "RbVHDL::Ast.logical_xnor(...)" do
      it "RbVHDL::Ast.logical_xnor(0, 1)" do
        expr = RbVHDL::Ast.logical_xnor(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalXnor
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.logical_xnor(0, 1, 2)" do
        expr = RbVHDL::Ast.logical_xnor(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalXnor
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalXnor
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.logical_xnor(logical_xnor(0, 1), 2)" do
        expr = RbVHDL::Ast.logical_xnor(RbVHDL::Ast.logical_xnor(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::LogicalXnor
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::LogicalXnor
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end

  describe "Equal" do
    describe "RbVHDL::Ast.equal(...)" do
      it "RbVHDL::Ast.equal(0, 1)" do
        expr = RbVHDL::Ast.equal(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::Equal
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "NotEqual" do
    describe "RbVHDL::Ast.not_equal(...)" do
      it "RbVHDL::Ast.not_equal(0, 1)" do
        expr = RbVHDL::Ast.not_equal(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::NotEqual
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "LessThan" do
    describe "RbVHDL::Ast.less_than(...)" do
      it "RbVHDL::Ast.less_than(0, 1)" do
        expr = RbVHDL::Ast.less_than(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::LessThan
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "LessThanEqual" do
    describe "RbVHDL::Ast.less_than_equal(...)" do
      it "RbVHDL::Ast.less_than_equal(0, 1)" do
        expr = RbVHDL::Ast.less_than_equal(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::LessThanEqual
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "GreaterThan" do
    describe "RbVHDL::Ast.greater_than(...)" do
      it "RbVHDL::Ast.greater_than(0, 1)" do
        expr = RbVHDL::Ast.greater_than(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::GreaterThan
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "GreaterThanEqual" do
    describe "RbVHDL::Ast.greater_than_equal(...)" do
      it "RbVHDL::Ast.greater_than_equal(0, 1)" do
        expr = RbVHDL::Ast.greater_than_equal(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::GreaterThanEqual
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "ShiftLeftLogical" do
    describe "RbVHDL::Ast.shift_left_logical(...)" do
      it "RbVHDL::Ast.shift_left_logical(0, 1)" do
        expr = RbVHDL::Ast.shift_left_logical(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ShiftLeftLogical
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "ShiftRightLogical" do
    describe "RbVHDL::Ast.shift_right_logical(...)" do
      it "RbVHDL::Ast.shift_right_logical(0, 1)" do
        expr = RbVHDL::Ast.shift_right_logical(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ShiftRightLogical
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "ShiftLeftArithmetic" do
    describe "RbVHDL::Ast.shift_left_arithmetic(...)" do
      it "RbVHDL::Ast.shift_left_arithmetic(0, 1)" do
        expr = RbVHDL::Ast.shift_left_arithmetic(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ShiftLeftArithmetic
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "ShiftRightArithmetic" do
    describe "RbVHDL::Ast.shift_right_arithmetic(...)" do
      it "RbVHDL::Ast.shift_right_arithmetic(0, 1)" do
        expr = RbVHDL::Ast.shift_right_arithmetic(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ShiftRightArithmetic
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "RotateLeft" do
    describe "RbVHDL::Ast.rotate_left(...)" do
      it "RbVHDL::Ast.rotate_left(0, 1)" do
        expr = RbVHDL::Ast.rotate_left(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::RotateLeft
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "RotateRight" do
    describe "RbVHDL::Ast.rotate_right(...)" do
      it "RbVHDL::Ast.rotate_right(0, 1)" do
        expr = RbVHDL::Ast.rotate_right(0, 1)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::RotateRight
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 0
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 1
      end
    end
  end

  describe "UnaryPlus" do
    describe "RbVHDL::Ast.unary_plus(...)" do
      it "RbVHDL::Ast.unary_plus(10)" do
        expr = RbVHDL::Ast.unary_plus(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::UnaryPlus
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "UnaryMinus" do
    describe "RbVHDL::Ast.unary_minus(...)" do
      it "RbVHDL::Ast.unary_minus(10)" do
        expr = RbVHDL::Ast.unary_minus(10)
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::UnaryMinus
        expect(expr._operand.size         ).to eq 1
        expect(expr._operand[0].class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer  ).to eq 10
      end
    end
  end

  describe "Addition" do
    describe "RbVHDL::Ast.addition(...)" do
      it "RbVHDL::Ast.addition(0, 1)" do
        expr = RbVHDL::Ast.addition(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.addition(0, 1, 2)" do
        expr = RbVHDL::Ast.addition(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.addition(addition(0, 1), 2)" do
        expr = RbVHDL::Ast.addition(RbVHDL::Ast.addition(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.addition(subtraction(0, 1), 2)" do
        expr = RbVHDL::Ast.addition(RbVHDL::Ast.subtraction(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.addition(unary_minus(1), 2)" do
        expr = RbVHDL::Ast.addition(RbVHDL::Ast.unary_minus(1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Addition
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::UnaryMinus
        expect(expr._operand[0]._operand.size       ).to eq 1
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end
  

  describe "Subtraction" do
    describe "RbVHDL::Ast.subtraction(...)" do
      it "RbVHDL::Ast.subtraction(0, 1)" do
        expr = RbVHDL::Ast.subtraction(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.subtraction(0, 1, 2)" do
        expr = RbVHDL::Ast.subtraction(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.subtraction(subtraction(0, 1), 2)" do
        expr = RbVHDL::Ast.subtraction(RbVHDL::Ast.subtraction(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.subtraction(unary_plus(1), 2)" do
        expr = RbVHDL::Ast.subtraction(RbVHDL::Ast.unary_plus(1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Subtraction
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::UnaryPlus
        expect(expr._operand[0]._operand.size       ).to eq 1
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end
  
  describe "Concatenation" do
    describe "RbVHDL::Ast.concatenation(...)" do
      it "RbVHDL::Ast.concatenation(0, 1)" do
        expr = RbVHDL::Ast.concatenation(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.concatenation(0, 1, 2)" do
        expr = RbVHDL::Ast.concatenation(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.concatenation(concatenation(0, 1), 2)" do
        expr = RbVHDL::Ast.concatenation(RbVHDL::Ast.concatenation(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.concatenation(unary_plus(1), 2)" do
        expr = RbVHDL::Ast.concatenation(RbVHDL::Ast.unary_plus(1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Concatenation
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::UnaryPlus
        expect(expr._operand[0]._operand.size       ).to eq 1
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end
  
  describe "Multiplication" do
    describe "RbVHDL::Ast.multiplication(...)" do
      it "RbVHDL::Ast.multiplication(0, 1)" do
        expr = RbVHDL::Ast.multiplication(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Multiplication
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.multiplication(0, 1, 2)" do
        expr = RbVHDL::Ast.multiplication(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Multiplication
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Multiplication
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.multiplication(multiplication(0, 1), 2)" do
        expr = RbVHDL::Ast.multiplication(RbVHDL::Ast.multiplication(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Multiplication
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Multiplication
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end
  
  describe "Division" do
    describe "RbVHDL::Ast.division(...)" do
      it "RbVHDL::Ast.division(0, 1)" do
        expr = RbVHDL::Ast.division(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Division
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.division(0, 1, 2)" do
        expr = RbVHDL::Ast.division(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Division
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Division
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.division(division(0, 1), 2)" do
        expr = RbVHDL::Ast.division(RbVHDL::Ast.division(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Division
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Division
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end
  
  describe "Modulo" do
    describe "RbVHDL::Ast.modulo(...)" do
      it "RbVHDL::Ast.modulo(0, 1)" do
        expr = RbVHDL::Ast.modulo(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Modulo
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.modulo(0, 1, 2)" do
        expr = RbVHDL::Ast.modulo(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Modulo
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Modulo
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.modulo(modulo(0, 1), 2)" do
        expr = RbVHDL::Ast.modulo(RbVHDL::Ast.modulo(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Modulo
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Modulo
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end
  
  describe "Remainder" do
    describe "RbVHDL::Ast.remainder(...)" do
      it "RbVHDL::Ast.remainder(0, 1)" do
        expr = RbVHDL::Ast.remainder(0, 1)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Remainder
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer            ).to eq 0
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 1
      end
      it "RbVHDL::Ast.remainder(0, 1, 2)" do
        expr = RbVHDL::Ast.remainder(0, 1, 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Remainder
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Remainder
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
      it "RbVHDL::Ast.remainder(remainder(0, 1), 2)" do
        expr = RbVHDL::Ast.remainder(RbVHDL::Ast.remainder(0, 1), 2)
        expect(expr.class                           ).to eq RbVHDL::Ast::Expression::Remainder
        expect(expr._operand.size                   ).to eq 2
        expect(expr._operand[0].class               ).to eq RbVHDL::Ast::Expression::Remainder
        expect(expr._operand[0]._operand.size       ).to eq 2
        expect(expr._operand[0]._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[0]._integer).to eq 0
        expect(expr._operand[0]._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._operand[1]._integer).to eq 1
        expect(expr._operand[1].class               ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer            ).to eq 2
      end
    end
  end
  
  describe "Exponentiation" do
    describe "RbVHDL::Ast.exponentiation(...)" do
      it "RbVHDL::Ast.exponentiation(2, 3)" do
        expr = RbVHDL::Ast.exponentiation(2, 3)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::Exponentiation
        expect(expr._operand.size       ).to eq 2
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 2
        expect(expr._operand[1].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[1]._integer).to eq 3
      end
    end
  end
  
  describe "Abs" do
    describe "RbVHDL::Ast.abs(...)" do
      it "RbVHDL::Ast.abs(10)" do
        expr = RbVHDL::Ast.abs(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::Abs
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "Not" do
    describe "RbVHDL::Ast.not(...)" do
      it "RbVHDL::Ast.not(10)" do
        expr = RbVHDL::Ast.not(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::Not
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "ReductionAnd" do
    describe "RbVHDL::Ast.reduction_and(...)" do
      it "RbVHDL::Ast.reduction_and(10)" do
        expr = RbVHDL::Ast.reduction_and(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ReductionAnd
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "ReductionNand" do
    describe "RbVHDL::Ast.reduction_nand(...)" do
      it "RbVHDL::Ast.reduction_nand(10)" do
        expr = RbVHDL::Ast.reduction_nand(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ReductionNand
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "ReductionOr" do
    describe "RbVHDL::Ast.reduction_or(...)" do
      it "RbVHDL::Ast.reduction_or(10)" do
        expr = RbVHDL::Ast.reduction_or(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ReductionOr
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "ReductionNor" do
    describe "RbVHDL::Ast.reduction_nor(...)" do
      it "RbVHDL::Ast.reduction_nor(10)" do
        expr = RbVHDL::Ast.reduction_nor(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ReductionNor
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "ReductionXor" do
    describe "RbVHDL::Ast.reduction_xor(...)" do
      it "RbVHDL::Ast.reduction_xor(10)" do
        expr = RbVHDL::Ast.reduction_xor(10)
        expect(expr.class               ).to eq RbVHDL::Ast::Expression::ReductionXor
        expect(expr._operand.size       ).to eq 1
        expect(expr._operand[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer).to eq 10
      end
    end
  end

  describe "ReductionXnor" do
    describe "RbVHDL::Ast.reduction_xnor(...)" do
      it "RbVHDL::Ast.reduction_xnor(10)" do
        expr = RbVHDL::Ast.reduction_xnor(10)
        expect(expr.class                 ).to eq RbVHDL::Ast::Expression::ReductionXnor
        expect(expr._operand.size         ).to eq 1
        expect(expr._operand[0].class     ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._operand[0]._integer  ).to eq 10
      end
    end
  end

  describe "ParenthesizedExpression" do
    describe "RbVHDL::Ast.parenthesized_expression(...)" do
      it "RbVHDL::Ast.parenthesized_expression(logical_and(0, 1))" do
        expr = RbVHDL::Ast.parenthesized_expression(RbVHDL::Ast.logical_and(0, 1))
        expect(expr.class                      ).to eq RbVHDL::Ast::Expression::ParenthesizedExpression
        expect(expr._expr.class                ).to eq RbVHDL::Ast::Expression::LogicalAnd
        expect(expr._expr._operand.size        ).to eq 2
        expect(expr._expr._operand[0].class    ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._operand[0]._integer ).to eq 0
        expect(expr._expr._operand[1].class    ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(expr._expr._operand[1]._integer ).to eq 1
      end
    end
  end
end

