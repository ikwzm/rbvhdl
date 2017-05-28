require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Variable' do

  context "new" do

    it "new(identifier('index'), subtype_indication('integer'), expression(decimal_literal(8)))" do
      ident = RbVHDL::Ast.identifier('index')
      type  = RbVHDL::Ast.subtype_indication('integer')
      value = RbVHDL::Ast.expression(RbVHDL::Ast.decimal_literal(8))
      var   = RbVHDL::Ast::Declaration::Variable.new(nil, [ident], type, value)
      expect(var.class              ).to eq RbVHDL::Ast::Declaration::Variable
      expect(var._owner             ).to eq nil
      expect(var._identifier_list   ).to eq [ident]
      expect(var._subtype_indication).to eq type
      expect(var._value_expression  ).to eq value
    end

    it "new(identifier('queue'), subtype_indication('QUEUE_VECTOR')._to(decimal_literal(0),decimal_literal(3)), nil)" do
      ident = RbVHDL::Ast.identifier('queue')
      type  = RbVHDL::Ast.subtype_indication('QUEUE_VECTOR')._to(RbVHDL::Ast.decimal_literal(0),RbVHDL::Ast.decimal_literal(3))
      var   = RbVHDL::Ast::Declaration::Variable.new(nil, [ident], type, nil)
      expect(var.class              ).to eq RbVHDL::Ast::Declaration::Variable
      expect(var._owner             ).to eq nil
      expect(var._identifier_list   ).to eq [ident]
      expect(var._subtype_indication).to eq type
      expect(var._value_expression  ).to eq nil
    end

    it "variable_declaration(nil, 'i', 'integer')" do
      var = RbVHDL::Ast.variable_declaration(nil, 'i', 'integer')
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Variable
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:i]
      expect(var._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(var._subtype_indication._type_mark      ).to eq :integer
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression                   ).to eq nil
    end
      
    it "variable_declaration(nil, 'i', 'integer', 8)" do
      var = RbVHDL::Ast.variable_declaration(nil, 'i', 'integer', RbVHDL::Ast.decimal_literal(8))
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Variable
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:i]
      expect(var._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(var._subtype_indication._type_mark      ).to eq :integer
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression.class             ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(var._value_expression._integer          ).to eq 8
    end
      
  end
end
