require "spec_helper"

describe 'RbVHDL::Ast::Declaration::SubtypeDecl' do

  context "new" do

    it "new(nil, identifier('a_type'), subtype_indication('unsigned')._downto(decimal_literal(7), decimal_literal(0)))" do
      type = RbVHDL::Ast.subtype_indication('unsigned')._downto(RbVHDL::Ast.decimal_literal(7), RbVHDL::Ast.decimal_literal(0))
      decl = RbVHDL::Ast::Declaration::SubtypeDecl.new(nil, RbVHDL::Ast.identifier('a_type'), type)
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::SubtypeDecl
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :a_type
      expect(decl._subtype_indication                 ).to eq type
    end

    it "new(nil, identifier('a_type'), subtype_indication('unsigned')._downto(decimal_literal(7), decimal_literal(0)))" do
      type = RbVHDL::Ast.subtype_indication('unsigned')._downto(RbVHDL::Ast.decimal_literal(7), RbVHDL::Ast.decimal_literal(0))
      decl = RbVHDL::Ast.subtype_declaration(nil, RbVHDL::Ast.identifier('a_type'), type)
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::SubtypeDecl
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :a_type
      expect(decl._subtype_indication                 ).to eq type
    end

  end

end
