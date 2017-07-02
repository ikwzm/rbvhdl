require "spec_helper"

describe 'RbVHDL::Ast::Declaration::ArchitectureBody' do

  context "new" do

    it "new(nil, RbVHDL::Ast.identifier('MODEL'), RbVHDL::Ast.name('TEST'))" do
      body = RbVHDL::Ast::Declaration::ArchitectureBody.new(nil, RbVHDL::Ast.identifier('MODEL'), RbVHDL::Ast.name('TEST'))
      expect(body.class                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                          ).to eq nil
      expect(body._identifier.class               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                     ).to eq :MODEL
      expect(body._entity_name.class              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name              ).to eq :TEST
      expect(body._declarative_item_list          ).to eq []
      expect(body._statement_list                 ).to eq []
    end

    it "new(nil, RbVHDL::Ast.identifier('MODEL'), RbVHDL::Ast.name('TEST')){...}" do
      body = RbVHDL::Ast::Declaration::ArchitectureBody.new(nil, RbVHDL::Ast.identifier('MODEL'), RbVHDL::Ast.name('TEST')) {
        _signal_declaration('sig0', RbVHDL::Ast.subtype_indication('std_logic'))
      }
      expect(body.class                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                          ).to eq nil
      expect(body._identifier.class               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                     ).to eq :MODEL
      expect(body._entity_name.class              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name              ).to eq :TEST
      expect(body._declarative_item_list.size     ).to eq 1
      expect(body._declarative_item_list[0].class ).to eq RbVHDL::Ast::Declaration::Signal
      expect(body._declarative_item_list[0]._owner).to eq body
      expect(body._statement_list                 ).to eq []
    end
  end

  context "RbVHDL::Ast.architecture_body" do

    it "architecture_body('MODEL', 'TEST')" do
      body = RbVHDL::Ast.architecture_body(nil, 'MODEL', 'TEST')
      expect(body.class                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                          ).to eq nil
      expect(body._identifier.class               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                     ).to eq :MODEL
      expect(body._entity_name.class              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name              ).to eq :TEST
      expect(body._declarative_item_list          ).to eq []
      expect(body._statement_list                 ).to eq []
    end
    
    it "architecture_body('MODEL', 'TEST'){...}" do
      body = RbVHDL::Ast.architecture_body(nil, 'MODEL', 'TEST'){
        _signal_declaration('sig0', RbVHDL::Ast.subtype_indication('std_logic'))
      }
      expect(body.class                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                          ).to eq nil
      expect(body._identifier.class               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                     ).to eq :MODEL
      expect(body._entity_name.class              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name              ).to eq :TEST
      expect(body._declarative_item_list.size     ).to eq 1
      expect(body._declarative_item_list[0].class ).to eq RbVHDL::Ast::Declaration::Signal
      expect(body._declarative_item_list[0]._owner).to eq body
      expect(body._statement_list                 ).to eq []
    end
  end

  context "RbVHDL::Ast::Declaration::Methods::BlockItem" do

    it "_integer_type_declaration" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      decl = body._integer_type_declaration('INT08_TYPE', RbVHDL::Ast.range_to(0, 7))

      expect(body.class                                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                                          ).to eq design_unit
      expect(body._identifier.class                               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                                     ).to eq :MODEL
      expect(body._entity_name.class                              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class                        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name                              ).to eq :TEST
      expect(body._declarative_item_list                          ).to eq [decl]
      expect(body._statement_list                                 ).to eq []
      expect(decl.class                                           ).to eq RbVHDL::Ast::Declaration::IntegerType
      expect(decl._owner                                          ).to eq body
      expect(decl._identifier.class                               ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                     ).to eq :INT08_TYPE
      expect(decl._type_definition.class                          ).to eq RbVHDL::Ast::Type::IntegerDefinition
      expect(decl._type_definition._range._l_expr.class           ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer        ).to eq 0
      expect(decl._type_definition._range._r_expr.class           ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer        ).to eq 7
    end

    it "_constant_declaration" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      decl = body._constant_declaration('sig1', 'INT08_TYPE', 5)
      expect(body.class                                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                                          ).to eq design_unit
      expect(body._identifier.class                               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                                     ).to eq :MODEL
      expect(body._entity_name.class                              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class                        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name                              ).to eq :TEST
      expect(body._declarative_item_list                          ).to eq [decl]
      expect(body._statement_list                                 ).to eq []
      expect(decl.class                                           ).to eq RbVHDL::Ast::Declaration::Constant
      expect(decl._owner                                          ).to eq body
      expect(decl._identifier_list.size                           ).to eq 1
      expect(decl._identifier_list[0].class                       ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier_list[0]                             ).to eq :sig1
      expect(decl._subtype_indication.class                       ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._subtype_indication._type_mark.class            ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._subtype_indication._type_mark._name.class      ).to eq RbVHDL::Ast::Identifier
      expect(decl._subtype_indication._type_mark._name            ).to eq :INT08_TYPE
      expect(decl._subtype_indication._constraint                 ).to eq nil
      expect(decl._value_expression.class                         ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._value_expression._integer                      ).to eq 5
    end

    it "_floating_type_declaration" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      decl = body._floating_type_declaration('FLOAT_TYPE', RbVHDL::Ast.range_to(0, 0))
      expect(body.class                                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                                          ).to eq design_unit
      expect(body._identifier.class                               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                                     ).to eq :MODEL
      expect(body._entity_name.class                              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class                        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name                              ).to eq :TEST
      expect(body._declarative_item_list                          ).to eq [decl]
      expect(body._statement_list                                 ).to eq []
      expect(decl.class                                           ).to eq RbVHDL::Ast::Declaration::FloatingType
      expect(decl._owner                                          ).to eq body
      expect(decl._identifier.class                               ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                     ).to eq :FLOAT_TYPE
      expect(decl._type_definition.class                          ).to eq RbVHDL::Ast::Type::FloatingDefinition
      expect(decl._type_definition._range._l_expr.class           ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer        ).to eq 0
      expect(decl._type_definition._range._r_expr.class           ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer        ).to eq 0
    end
  
    it "_enumeration_type_declaration" do
      design_unit = RbVHDL::Ast::DesignUnit.new
      body = design_unit._architecture('MODEL', 'TEST')
      decl = body._enumeration_type_declaration('STATE_TYPE', ['IDLE_STATE'])
      decl._enum!('RUN_STATE')
      decl._enum!('DONE_STATE')
      expect(body.class                                           ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                                          ).to eq design_unit
      expect(body._identifier.class                               ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier                                     ).to eq :MODEL
      expect(body._entity_name.class                              ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class                        ).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name                              ).to eq :TEST
      expect(body._declarative_item_list                          ).to eq [decl]
      expect(body._statement_list                                 ).to eq []
      expect(decl.class                                           ).to eq RbVHDL::Ast::Declaration::EnumerationType
      expect(decl._owner                                          ).to eq body
      expect(decl._identifier                                     ).to eq :STATE_TYPE
      expect(decl._type_definition.class                          ).to eq RbVHDL::Ast::Type::EnumerationDefinition
      expect(decl._type_definition._enum_list.size                ).to eq 3
      expect(decl._type_definition._enum_list[0].class            ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[0]                  ).to eq :IDLE_STATE
      expect(decl._type_definition._enum_list[1].class            ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[1]                  ).to eq :RUN_STATE
      expect(decl._type_definition._enum_list[2].class            ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[2]                  ).to eq :DONE_STATE
    end
  end
end  
