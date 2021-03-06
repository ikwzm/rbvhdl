require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Constant' do

  context "new" do

    it "new(nil, identifier_list('width'), subtype_indication('integer'), 8)" do
      var = RbVHDL::Ast::Declaration::Constant.new(nil, RbVHDL::Ast.identifier_list('width'), RbVHDL::Ast.subtype_indication('integer'), RbVHDL::Ast.expression(8))
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Constant
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:width]
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(var._subtype_indication._type_mark._name).to eq :integer
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(var._value_expression._integer          ).to eq 8
    end

    it "new(nil, identifier_list('width'), subtype_indication('integer'), nil)" do
      var = RbVHDL::Ast::Declaration::Constant.new(nil, RbVHDL::Ast.identifier_list('width'), RbVHDL::Ast.subtype_indication('integer'), nil)
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Constant
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:width]
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(var._subtype_indication._type_mark._name).to eq :integer
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression                   ).to eq nil
    end
  end

  context "RbVHDL::Ast.constant_declaration" do

    it "constant_declaration(nil, 'width', 'integer', 8)" do
      var = RbVHDL::Ast.constant_declaration(nil, 'width', 'integer', 8)
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Constant
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:width]
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(var._subtype_indication._type_mark._name).to eq :integer
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(var._value_expression._integer          ).to eq 8
    end
      
    it "constant_declaration(nil, 'width', 'integer', nil)" do
      var = RbVHDL::Ast.constant_declaration(nil, 'width', 'integer', nil)
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Constant
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:width]
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(var._subtype_indication._type_mark._name).to eq :integer
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression                   ).to eq nil
    end
      
    it "constant_declaration(nil, 'width', 'integer')" do
      var = RbVHDL::Ast.constant_declaration(nil, 'width', 'integer')
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Constant
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:width]
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(var._subtype_indication._type_mark._name).to eq :integer
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression                   ).to eq nil
    end
      
  end
end
