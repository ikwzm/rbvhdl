require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Group' do

  context "new" do

    it "new(nil, identifier('group'), name('template'))" do
      decl = RbVHDL::Ast::Declaration::Group.new(nil, RbVHDL::Ast.identifier('group'), RbVHDL::Ast.name('template'))
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Group
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._template_name.class                ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._template_name._name.class          ).to eq RbVHDL::Ast::Identifier
      expect(decl._template_name._name                ).to eq :template
      expect(decl._name_list                          ).to eq []
    end
    
    it "new(nil, identifier('group'), name('template'), [name('name0')])" do
      decl = RbVHDL::Ast::Declaration::Group.new(nil, RbVHDL::Ast.identifier('group'), RbVHDL::Ast.name('template'), [RbVHDL::Ast.name('name0')])
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Group
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._template_name.class                ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._template_name._name.class          ).to eq RbVHDL::Ast::Identifier
      expect(decl._template_name._name                ).to eq :template
      expect(decl._name_list.size                     ).to eq 1
      expect(decl._name_list[0].class                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name_list[0]._name.class           ).to eq RbVHDL::Ast::Identifier
      expect(decl._name_list[0]._name                 ).to eq :name0
    end

    it "RbVHDL::Ast.group_declaration(nil, 'group', 'template')" do
      decl = RbVHDL::Ast.group_declaration(nil, 'group', 'template')
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Group
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._template_name.class                ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._template_name._name.class          ).to eq RbVHDL::Ast::Identifier
      expect(decl._template_name._name                ).to eq :template
      expect(decl._name_list                          ).to eq []
    end

    it "RbVHDL::Ast.group_declaration(nil, 'group', 'template', RbVHDL::Ast.name('name0'))" do
      decl = RbVHDL::Ast.group_declaration(nil, 'group', 'template', RbVHDL::Ast.name('name0'))
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Group
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._template_name.class                ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._template_name._name.class          ).to eq RbVHDL::Ast::Identifier
      expect(decl._template_name._name                ).to eq :template
      expect(decl._name_list.size                     ).to eq 1
      expect(decl._name_list[0].class                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name_list[0]._name.class           ).to eq RbVHDL::Ast::Identifier
      expect(decl._name_list[0]._name                 ).to eq :name0
    end

    it "RbVHDL::Ast.group_declaration(nil, 'group', 'template', [RbVHDL::Ast.name('name0'), RbVHDL::Ast.name('name1')])" do
      decl = RbVHDL::Ast.group_declaration(nil, 'group', 'template', [RbVHDL::Ast.name('name0'), RbVHDL::Ast.name('name1')])
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Group
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :group
      expect(decl._template_name.class                ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._template_name._name.class          ).to eq RbVHDL::Ast::Identifier
      expect(decl._template_name._name                ).to eq :template
      expect(decl._name_list.size                     ).to eq 2
      expect(decl._name_list[0].class                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name_list[0]._name.class           ).to eq RbVHDL::Ast::Identifier
      expect(decl._name_list[0]._name                 ).to eq :name0
      expect(decl._name_list[1].class                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._name_list[1]._name.class           ).to eq RbVHDL::Ast::Identifier
      expect(decl._name_list[1]._name                 ).to eq :name1
    end

  end
end
