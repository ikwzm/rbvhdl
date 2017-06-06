require "spec_helper"

describe 'RbVHDL::Ast::Expression::Literal' do

  describe 'DecimalLiteral' do

    context "decimal_literal()" do

      it "decimal_literal(10)" do
        literal = RbVHDL::Ast.decimal_literal(10)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq 10
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent         ).to eq nil
      end

      it "decimal_literal(10)._fraction!(5)" do
        literal = RbVHDL::Ast.decimal_literal(10)._fraction!(5)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq 10
        expect(literal._fraction         ).to eq 5
        expect(literal._exponent         ).to eq nil
      end

      it "decimal_literal(10)._exponent!(3)" do
        literal = RbVHDL::Ast.decimal_literal(10)._exponent!(3)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq 10
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq 3
        expect(literal._exponent._sign   ).to eq nil
      end

      it "decimal_literal(10)._exponent!(-2)" do
        literal = RbVHDL::Ast.decimal_literal(10)._exponent!(-2)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq 10
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq -2
        expect(literal._exponent._sign   ).to eq :"-"
      end

      it "decimal_literal(10)._fraction!(3)._exponent!(-2)" do
        literal = RbVHDL::Ast.decimal_literal(10)._fraction!(3)._exponent!(-2)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq 10
        expect(literal._fraction         ).to eq 3
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq -2
        expect(literal._exponent._sign   ).to eq :"-"
      end

      it "decimal_literal(0.0)" do
        literal = RbVHDL::Ast.decimal_literal(0.0)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq "0"
        expect(literal._fraction         ).to eq "0"
        expect(literal._exponent         ).to eq nil
      end
        
      it "decimal_literal(0.1)" do
        literal = RbVHDL::Ast.decimal_literal(0.1)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq "0"
        expect(literal._fraction         ).to eq "1"
        expect(literal._exponent         ).to eq nil
      end
        
      it "decimal_literal(1.0)" do
        literal = RbVHDL::Ast.decimal_literal(1.0)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq "1"
        expect(literal._fraction         ).to eq "0"
        expect(literal._exponent         ).to eq nil
      end
        
      it "decimal_literal(0.0000000001)" do
        literal = RbVHDL::Ast.decimal_literal(0.0000000001)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq "1"
        expect(literal._fraction         ).to eq "0"
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq -10
        expect(literal._exponent._sign   ).to eq :"-"
      end
        
      it "decimal_literal(0.0000000001)" do
        literal = RbVHDL::Ast.decimal_literal(0.0000000001)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq "1"
        expect(literal._fraction         ).to eq "0"
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq -10
        expect(literal._exponent._sign   ).to eq :"-"
      end
        
      it "decimal_literal(123456789012345670.0)" do
        literal = RbVHDL::Ast.decimal_literal(123456789012345678.9)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq "1"
        expect(literal._fraction         ).to eq "2345678901234568"
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq 17
        expect(literal._exponent._sign   ).to eq :"+"
      end
        
      it "decimal_literal(123456789012345670.0)" do
        literal = RbVHDL::Ast.decimal_literal(123456789012345678.9)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._integer          ).to eq "1"
        expect(literal._fraction         ).to eq "2345678901234568"
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq 17
        expect(literal._exponent._sign   ).to eq :"+"
      end
        
    end
  end

  describe 'BasedLiteral' do

    context "based_literal()" do

      it "based_literal(10, '540')" do
        literal = RbVHDL::Ast.based_literal(10, '540')
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._base             ).to eq 10
        expect(literal._integer          ).to eq '540'
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent         ).to eq nil
      end

      it "based_literal(10, '540')._fraction!('0025')" do
        literal = RbVHDL::Ast.based_literal(10, '540')._fraction!('0025')
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._base             ).to eq 10
        expect(literal._integer          ).to eq '540'
        expect(literal._fraction         ).to eq '0025'
        expect(literal._exponent         ).to eq nil
      end

      it "based_literal(10, '540')._exponent!(5)" do
        literal = RbVHDL::Ast.based_literal(10, '540')._exponent!(5)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._base             ).to eq 10
        expect(literal._integer          ).to eq '540'
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq 5
        expect(literal._exponent._sign   ).to eq nil
      end

      it "based_literal(10, '540')._exponent!(-1)" do
        literal = RbVHDL::Ast.based_literal(10, '540')._exponent!(-1)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._base             ).to eq 10
        expect(literal._integer          ).to eq '540'
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq -1
        expect(literal._exponent._sign   ).to eq :"-"
      end

      it "based_literal(10, '540')._exponent!(3,true)" do
        literal = RbVHDL::Ast.based_literal(10, '540')._exponent!(3, true)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._base             ).to eq 10
        expect(literal._integer          ).to eq '540'
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent.class   ).to eq RbVHDL::Ast::Expression::Exponent
        expect(literal._exponent._number ).to eq 3
        expect(literal._exponent._sign   ).to eq :"+"
      end

      it "decimal_literal(540)._to_based_literal(10)" do
        literal = RbVHDL::Ast.decimal_literal(540)._to_based_literal(10)
        expect(literal.class             ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._base             ).to eq 10
        expect(literal._integer          ).to eq '540'
        expect(literal._fraction         ).to eq nil
        expect(literal._exponent         ).to eq nil
      end
      
    end
  end

  describe 'PhysicalLiteral' do
    
    context "decimal_literal()._to_physical_literal()" do
      it "decimal_literal(10)._to_physical_literal('ns')" do
        literal = RbVHDL::Ast.decimal_literal(10)._to_physical_literal('ns')
        expect(literal.class                  ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
        expect(literal._decimal.class         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(literal._decimal._integer      ).to eq 10
        expect(literal._decimal._fraction     ).to eq nil
        expect(literal._decimal._exponent     ).to eq nil
        expect(literal._unit_name.class       ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(literal._unit_name._name.class ).to eq RbVHDL::Ast::Identifier
        expect(literal._unit_name._name       ).to eq :ns
      end
    end
      
    context "based_literal()._to_physical_literal()" do
      it "based_literal(10, '2')._to_physical_literal('ns')" do
        literal = RbVHDL::Ast.based_literal(10,'2')._to_physical_literal('ns')
        expect(literal.class                  ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
        expect(literal._decimal.class         ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._decimal._base         ).to eq 10
        expect(literal._decimal._integer      ).to eq '2'
        expect(literal._decimal._fraction     ).to eq nil
        expect(literal._decimal._exponent     ).to eq nil
        expect(literal._unit_name.class       ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(literal._unit_name._name.class ).to eq RbVHDL::Ast::Identifier
        expect(literal._unit_name._name       ).to eq :ns
      end
    end

    context "RbVHDL::Ast.physical_literal()" do
      it "RbVHDL::Ast.physical_literal(based_literal(10,'2'), 'ns')" do
        literal = RbVHDL::Ast.physical_literal(RbVHDL::Ast.based_literal(10,'2'), 'ns')
        expect(literal.class                  ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
        expect(literal._decimal.class         ).to eq RbVHDL::Ast::Expression::BasedLiteral
        expect(literal._decimal._base         ).to eq 10
        expect(literal._decimal._integer      ).to eq '2'
        expect(literal._decimal._fraction     ).to eq nil
        expect(literal._decimal._exponent     ).to eq nil
        expect(literal._unit_name.class       ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(literal._unit_name._name.class ).to eq RbVHDL::Ast::Identifier
        expect(literal._unit_name._name       ).to eq :ns
      end
    end

  end

  describe 'CharacterLiteral' do
    context "character_literal()" do
      it "character_literal('0')" do
        literal = RbVHDL::Ast.character_literal('0')
        expect(literal.class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
        expect(literal._value).to eq '0'
      end
    end
  end
  
  describe 'StringLiteral' do
    context "string_literal()" do
      it "string_literal('0')" do
        literal = RbVHDL::Ast.string_literal('0')
        expect(literal.class ).to eq RbVHDL::Ast::Expression::StringLiteral
        expect(literal._value).to eq '0'
      end
    end
  end
  
  describe 'BitStringLiteral' do
    context "bit_string_literal()" do
      it "bit_string_literal(nil, :B, '01001000')" do
        literal = RbVHDL::Ast.bit_string_literal(nil, :B, '01001000')
        expect(literal.class ).to eq RbVHDL::Ast::Expression::BitStringLiteral
        expect(literal._width).to eq nil
        expect(literal._base ).to eq :B
        expect(literal._value).to eq '01001000'
      end
      it "bit_string_literal(8, :X, 'A7')" do
        literal = RbVHDL::Ast.bit_string_literal(8, :X, 'A7')
        expect(literal.class ).to eq RbVHDL::Ast::Expression::BitStringLiteral
        expect(literal._width).to eq 8
        expect(literal._base ).to eq :X
        expect(literal._value).to eq 'A7'
      end
    end
  end
  
  describe 'NullLiteral' do
    context "null_literal" do
      it "null_literal" do
        literal = RbVHDL::Ast.null_literal
        expect(literal.class ).to eq RbVHDL::Ast::Expression::NullLiteral
      end
    end
  end
end
