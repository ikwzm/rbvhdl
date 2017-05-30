require "spec_helper"

describe 'RbVHDL::Ast::Declaration::GroupTemplate' do

  context "new" do

    it "new(nil, identifier('group'))" do
      decl = RbVHDL::Ast::Declaration::GroupTemplate.new(nil, RbVHDL::Ast.identifier('group'))
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::GroupTemplate
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._entity_class_list                  ).to eq []
    end

    it "new(nil, identifier('group'), [:entity, :architecture])" do
      decl = RbVHDL::Ast::Declaration::GroupTemplate.new(nil, RbVHDL::Ast.identifier('group'), [:entity, :architecture])
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::GroupTemplate
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._entity_class_list                  ).to eq [:entity, :architecture]
    end

    it "RbVHDL::Ast.group_template_declaration(nil,'group')" do
      decl = RbVHDL::Ast.group_template_declaration(nil,'group')
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::GroupTemplate
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._entity_class_list                  ).to eq []
    end

    it "RbVHDL::Ast.group_template_declaration(nil,'group', [:entity, :architecture])" do
      decl = RbVHDL::Ast.group_template_declaration(nil,'group', [:entity, :architecture])
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::GroupTemplate
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._entity_class_list                  ).to eq [:entity, :architecture]
    end

  end
end
