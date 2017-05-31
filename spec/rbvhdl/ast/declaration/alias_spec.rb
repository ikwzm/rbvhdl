require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Alias' do

  context "new" do

    it "new(nil, identifier('a_vec'), nil, name('a'), nil))" do
      decl = RbVHDL::Ast::Declaration::Alias.new(nil, RbVHDL::Ast.identifier('a_vec'), nil, RbVHDL::Ast.name('a'), nil)
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Alias
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :a_vec
      expect(decl._subtype_indication                 ).to eq nil
      expect(decl._name.class                         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name._name.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._name._name                         ).to eq :a
      expect(decl._signature                          ).to eq nil
    end

    it "RbVHDL::Ast.alias_declaration(nil, 'a_vec', nil, 'a', nil)" do
      decl = RbVHDL::Ast.alias_declaration(nil, 'a_vec', nil, 'a', nil)
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Alias
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :a_vec
      expect(decl._subtype_indication                 ).to eq nil
      expect(decl._name.class                         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name._name.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._name._name                         ).to eq :a
      expect(decl._signature                          ).to eq nil
    end

    it "RbVHDL::Ast.alias_declaration(nil, 'a_val', 'integer', 'a', nil)" do
      decl = RbVHDL::Ast.alias_declaration(nil, 'a_val', 'integer', 'a', nil)
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Alias
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :a_val
      expect(decl._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._subtype_indication._type_mark      ).to eq :integer
      expect(decl._name.class                         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name._name.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._name._name                         ).to eq :a
      expect(decl._signature                          ).to eq nil
    end
    
  end
end
