require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Signal' do

  context "new" do
    it "new('valid', 'std_logic', nil , '0')" do
      ident = RbVHDL::Ast.identifier_list('valid')
      type  = RbVHDL::Ast.subtype_indication('std_logic')
      mode  = nil
      value = RbVHDL::Ast.expression(RbVHDL::Ast.character_literal('0'))
      sig   = RbVHDL::Ast::Declaration::Signal.new(nil, ident, type, value, mode)
      expect(sig.class                               ).to eq RbVHDL::Ast::Declaration::Signal
      expect(sig._owner                              ).to eq nil
      expect(sig._identifier_list                    ).to eq [:valid]
      expect(sig._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
      expect(sig._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(sig._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(sig._subtype_indication._type_mark      ).to eq :std_logic
      expect(sig._subtype_indication._constraint     ).to eq nil
      expect(sig._mode                               ).to eq nil
      expect(sig._value_expression                   ).to eq value
    end

    it "new('ready', 'std_logic', :Out , nil)" do
      ident = RbVHDL::Ast.identifier_list('ready')
      type  = RbVHDL::Ast.subtype_indication('std_logic')
      mode  = nil
      value = nil
      sig   = RbVHDL::Ast::Declaration::Signal.new(nil, ident, type, value, mode)
      expect(sig.class                               ).to eq RbVHDL::Ast::Declaration::Signal
      expect(sig._owner                              ).to eq nil
      expect(sig._identifier_list                    ).to eq [:ready]
      expect(sig._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
      expect(sig._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(sig._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(sig._subtype_indication._type_mark      ).to eq :std_logic
      expect(sig._subtype_indication._constraint     ).to eq nil
      expect(sig._mode                               ).to eq nil
      expect(sig._value_expression                   ).to eq nil
    end

    it "signal_declaration(nil, 'valid', 'std_logic')" do
      var = RbVHDL::Ast.signal_declaration(nil, 'valid', 'std_logic')
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Signal
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:valid]
      expect(var._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(var._subtype_indication._type_mark      ).to eq :std_logic
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression                   ).to eq nil
    end
      
    it "signal_declaration(nil, 'valid', 'std_logic', RbVHDL::Ast.character_literal('0'))" do
      var = RbVHDL::Ast.signal_declaration(nil, 'valid', 'std_logic', RbVHDL::Ast.character_literal('0'))
      expect(var.class                               ).to eq RbVHDL::Ast::Declaration::Signal
      expect(var._owner                              ).to eq nil
      expect(var._identifier_list                    ).to eq [:valid]
      expect(var._identifier_list[0].class           ).to eq RbVHDL::Ast::Identifier
      expect(var._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(var._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(var._subtype_indication._type_mark      ).to eq :std_logic
      expect(var._subtype_indication._constraint     ).to eq nil
      expect(var._value_expression.class             ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(var._value_expression._value            ).to eq '0'
    end
      
  end

end
