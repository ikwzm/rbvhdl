require "spec_helper"

describe 'RbVHDL::Ast::Declaration::Component' do

  context "new" do

    it "new(nil, RbVHDL::Ast.identifier('SAMPLE'))" do
      decl = RbVHDL::Ast::Declaration::Component.new(nil, RbVHDL::Ast.identifier('SAMPLE'))
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Component
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :SAMPLE
      expect(decl._generic_interface_list             ).to eq []
      expect(decl._port_interface_list                ).to eq []
    end

    it "new(nil, RbVHDL::Ast.identifier('SAMPLE'){...})" do
      decl = RbVHDL::Ast::Declaration::Component.new(nil, RbVHDL::Ast.identifier('SAMPLE')){
        _generic_interface 'PARAM', RbVHDL::Ast.subtype_indication('integer'  ), 10
        _port_interface    'D'    , RbVHDL::Ast.subtype_indication('std_logic'), :in
        _port_interface    'Q'    , RbVHDL::Ast.subtype_indication('std_logic'), :out
      }
      expect(decl.class                                      ).to eq RbVHDL::Ast::Declaration::Component
      expect(decl._owner                                     ).to eq nil
      expect(decl._identifier.class                          ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                ).to eq :SAMPLE
      expect(decl._generic_interface_list.size               ).to eq 1
      expect(decl._generic_interface_list[0].class           ).to eq RbVHDL::Ast::Interface
      expect(decl._generic_interface_list[0]._owner          ).to eq decl
      expect(decl._generic_interface_list[0]._identifier_list).to eq [:PARAM]
      expect(decl._port_interface_list.size                  ).to eq 2
      expect(decl._port_interface_list[0].class              ).to eq RbVHDL::Ast::Interface
      expect(decl._port_interface_list[0]._owner             ).to eq decl
      expect(decl._port_interface_list[0]._identifier_list   ).to eq [:D]
      expect(decl._port_interface_list[1].class              ).to eq RbVHDL::Ast::Interface
      expect(decl._port_interface_list[1]._owner             ).to eq decl
      expect(decl._port_interface_list[1]._identifier_list   ).to eq [:Q]
    end
  end

  context "RbVHDL::Ast.component_declaration" do

    it "component_declaration(nil, 'SAMPLE')" do
      decl = RbVHDL::Ast.component_declaration(nil, 'SAMPLE')
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::Component
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :SAMPLE
      expect(decl._generic_interface_list             ).to eq []
      expect(decl._port_interface_list                ).to eq []
    end

    it "component_declaration(nil, 'SAMPLE'){...}" do
      decl = RbVHDL::Ast.component_declaration(nil, 'SAMPLE'){
        _generic_interface 'PARAM', RbVHDL::Ast.subtype_indication('integer'  ), 10
        _port_interface    'D'    , RbVHDL::Ast.subtype_indication('std_logic'), :in
        _port_interface    'Q'    , RbVHDL::Ast.subtype_indication('std_logic'), :out
      }
      expect(decl.class                                      ).to eq RbVHDL::Ast::Declaration::Component
      expect(decl._owner                                     ).to eq nil
      expect(decl._identifier.class                          ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                ).to eq :SAMPLE
      expect(decl._generic_interface_list.size               ).to eq 1
      expect(decl._generic_interface_list[0].class           ).to eq RbVHDL::Ast::Interface
      expect(decl._generic_interface_list[0]._owner          ).to eq decl
      expect(decl._generic_interface_list[0]._identifier_list).to eq [:PARAM]
      expect(decl._port_interface_list.size                  ).to eq 2
      expect(decl._port_interface_list[0].class              ).to eq RbVHDL::Ast::Interface
      expect(decl._port_interface_list[0]._owner             ).to eq decl
      expect(decl._port_interface_list[0]._identifier_list   ).to eq [:D]
      expect(decl._port_interface_list[1].class              ).to eq RbVHDL::Ast::Interface
      expect(decl._port_interface_list[1]._owner             ).to eq decl
      expect(decl._port_interface_list[1]._identifier_list   ).to eq [:Q]
    end
  end
  
end

