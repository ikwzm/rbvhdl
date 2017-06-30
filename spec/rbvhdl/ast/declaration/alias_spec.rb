require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Alias' do

  context "new" do

    it "new(nil, identifier('a_vec'), name('a')))" do
      decl = RbVHDL::Ast::Declaration::Alias.new(nil, RbVHDL::Ast.identifier('a_vec'), RbVHDL::Ast.name('a'))
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Alias
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :a_vec
      expect(decl._name.class                         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name._name.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._name._name                         ).to eq :a
      expect(decl._subtype_indication                 ).to eq nil
      expect(decl._signature                          ).to eq nil
    end

    it "RbVHDL::Ast.alias_declaration(nil, 'a_vec', 'a')" do
      decl = RbVHDL::Ast.alias_declaration(nil, 'a_vec', 'a')
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Alias
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :a_vec
      expect(decl._name.class                         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name._name.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._name._name                         ).to eq :a
      expect(decl._subtype_indication                 ).to eq nil
      expect(decl._signature                          ).to eq nil
    end

    it "RbVHDL::Ast.alias_declaration(nil, 'a_val', 'a', 'integer')" do
      decl = RbVHDL::Ast.alias_declaration(nil, 'a_val', 'a', 'integer')
      expect(decl.class                                     ).to eq RbVHDL::Ast::Declaration::Alias
      expect(decl._owner                                    ).to eq nil
      expect(decl._identifier.class                         ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                               ).to eq :a_val
      expect(decl._name.class                               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name._name.class                         ).to eq RbVHDL::Ast::Identifier
      expect(decl._name._name                               ).to eq :a
      expect(decl._subtype_indication.class                 ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._subtype_indication._type_mark.class      ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._subtype_indication._type_mark._name.class).to eq RbVHDL::Ast::Identifier
      expect(decl._subtype_indication._type_mark._name      ).to eq :integer
      expect(decl._signature                                ).to eq nil
    end
    
    it "RbVHDL::Ast.alias_declaration(nil, 'a_val', 'a', 'integer', signature('integer', 'integer')._return!('integer'))" do
      decl = RbVHDL::Ast.alias_declaration(nil, 'a_val', 'a', 'integer', RbVHDL::Ast.signature('integer', 'integer')._return!('integer'))
      expect(decl.class                                     ).to eq RbVHDL::Ast::Declaration::Alias
      expect(decl._owner                                    ).to eq nil
      expect(decl._identifier.class                         ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                               ).to eq :a_val
      expect(decl._name.class                               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name._name.class                         ).to eq RbVHDL::Ast::Identifier
      expect(decl._name._name                               ).to eq :a
      expect(decl._subtype_indication.class                 ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._subtype_indication._type_mark.class      ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._subtype_indication._type_mark._name.class).to eq RbVHDL::Ast::Identifier
      expect(decl._subtype_indication._type_mark._name      ).to eq :integer
      expect(decl._signature.class                          ).to eq RbVHDL::Ast::Expression::Signature
      expect(decl._signature._parameter_type_list.size      ).to eq 2
      expect(decl._signature._parameter_type_list[0].class  ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._signature._parameter_type_list[0]._name  ).to eq :integer
      expect(decl._signature._parameter_type_list[1].class  ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._signature._parameter_type_list[1]._name  ).to eq :integer
      expect(decl._signature._return_type.class             ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._signature._return_type._name             ).to eq :integer
    end
    
  end
end
