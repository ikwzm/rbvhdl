require "spec_helper"

describe 'RbVHDL::Ast::Declaration::ArchitectureBody' do
  
    design_unit = RbVHDL::Ast::DesignUnit.new
    body        = design_unit._architecture('MODEL', 'TEST')
    sig1_type   = body._integer_type_declaration(    'INT08_TYPE', RbVHDL::Ast.range_to(0, 7))
    sig1_decl   = body._constant_declaration('sig1', 'INT08_TYPE', 5)
    sig2_type   = body._floating_type_declaration(   'FLOAT_TYPE', RbVHDL::Ast.range_to(0, 0))
    sig2_decl   = body._signal_declaration(  'sig2', 'FLOAT_TYPE', nil, nil)
    sig3_type   = body._enumeration_type_declaration('STATE_TYPE', ['IDLE_STATE'])
    sig3_type._enum!('RUN_STATE')
    sig3_type._enum!('DONE_STATE')
    sig3_decl   = body._signal_declaration(  'sig3', 'STATE_TYPE', RbVHDL::Ast.name('IDLE_STATE'), nil)

    it "body = design_unit._architecture('MODEL', 'TEST')" do
      expect(body.class                   ).to eq RbVHDL::Ast::Declaration::ArchitectureBody
      expect(body._owner                  ).to eq design_unit
      expect(body._identifier.class       ).to eq RbVHDL::Ast::Identifier
      expect(body._identifier             ).to eq :MODEL
      expect(body._entity_name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(body._entity_name._name.class).to eq RbVHDL::Ast::Identifier
      expect(body._entity_name._name      ).to eq :TEST
    end

    it "sig1_type = body._integer_type_declaration('INT08_TYPE', RbVHDL::Ast::Type::Range._to(0, 7))" do
      expect(sig1_type.class                                          ).to eq RbVHDL::Ast::Declaration::IntegerType
      expect(sig1_type._owner                                         ).to eq body
      expect(sig1_type._identifier.class                              ).to eq RbVHDL::Ast::Identifier
      expect(sig1_type._identifier                                    ).to eq :INT08_TYPE
      expect(sig1_type._type_definition.class                         ).to eq RbVHDL::Ast::Type::IntegerDefinition
      expect(sig1_type._type_definition._range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(sig1_type._type_definition._range._l_expr._integer       ).to eq 0
      expect(sig1_type._type_definition._range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(sig1_type._type_definition._range._r_expr._integer       ).to eq 7
    end

    it "sig1_decl = body._constant_declaration('sig1', 'INT08_TYPE', nil, 5)" do
      expect(sig1_decl.class                                          ).to eq RbVHDL::Ast::Declaration::Constant
      expect(sig1_decl._owner                                         ).to eq body
      expect(sig1_decl._identifier_list.size                          ).to eq 1
      expect(sig1_decl._identifier_list[0].class                      ).to eq RbVHDL::Ast::Identifier
      expect(sig1_decl._identifier_list[0]                            ).to eq :sig1
      expect(sig1_decl._subtype_indication.class                      ).to eq RbVHDL::Ast::Type::Indication
      expect(sig1_decl._subtype_indication._type_mark.class           ).to eq RbVHDL::Ast::Type::Mark
      expect(sig1_decl._subtype_indication._type_mark                 ).to eq :INT08_TYPE
      expect(sig1_decl._subtype_indication._constraint                ).to eq nil
      expect(sig1_decl._value_expression.class                        ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(sig1_decl._value_expression._integer                     ).to eq 5
    end

    it "sig2_type = body._floating_type_declaration('FLOAT_TYPE', nil)" do
      expect(sig2_type.class                                          ).to eq RbVHDL::Ast::Declaration::FloatingType
      expect(sig2_type._owner                                         ).to eq body
      expect(sig2_type._identifier.class                              ).to eq RbVHDL::Ast::Identifier
      expect(sig2_type._identifier                                    ).to eq :FLOAT_TYPE
      expect(sig2_type._type_definition.class                         ).to eq RbVHDL::Ast::Type::FloatingDefinition
      expect(sig2_type._type_definition._range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(sig2_type._type_definition._range._l_expr._integer       ).to eq 0
      expect(sig2_type._type_definition._range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(sig2_type._type_definition._range._r_expr._integer       ).to eq 0
    end
      
    it "sig2_decl = body._signal_declaration('sig2', 'FLOAT_TYPE', nil, nil)" do
      expect(sig2_decl.class                                          ).to eq RbVHDL::Ast::Declaration::Signal
      expect(sig2_decl._owner                                         ).to eq body
      expect(sig2_decl._identifier_list.size                          ).to eq 1
      expect(sig2_decl._identifier_list[0].class                      ).to eq RbVHDL::Ast::Identifier
      expect(sig2_decl._identifier_list[0]                            ).to eq :sig2
      expect(sig2_decl._subtype_indication.class                      ).to eq RbVHDL::Ast::Type::Indication
      expect(sig2_decl._subtype_indication._type_mark.class           ).to eq RbVHDL::Ast::Type::Mark
      expect(sig2_decl._subtype_indication._type_mark                 ).to eq :FLOAT_TYPE
      expect(sig2_decl._subtype_indication._constraint                ).to eq nil
      expect(sig2_decl._mode                                          ).to eq nil
      expect(sig2_decl._value_expression                              ).to eq nil
    end

    it "sig3_type = body._enumeration_type_declaration('STATE_TYPE', ['IDLE_STATE', 'RUN_STATE', 'DONE_STATE'])" do
      expect(sig3_type.class                                          ).to eq RbVHDL::Ast::Declaration::EnumerationType
      expect(sig3_type._owner                                         ).to eq body
      expect(sig3_type._identifier                                    ).to eq :STATE_TYPE
      expect(sig3_type._type_definition.class                         ).to eq RbVHDL::Ast::Type::EnumerationDefinition
      expect(sig3_type._type_definition._enum_list.size               ).to eq 3
      expect(sig3_type._type_definition._enum_list[0].class           ).to eq RbVHDL::Ast::Identifier
      expect(sig3_type._type_definition._enum_list[0]                 ).to eq :IDLE_STATE
      expect(sig3_type._type_definition._enum_list[1].class           ).to eq RbVHDL::Ast::Identifier
      expect(sig3_type._type_definition._enum_list[1]                 ).to eq :RUN_STATE
      expect(sig3_type._type_definition._enum_list[2].class           ).to eq RbVHDL::Ast::Identifier
      expect(sig3_type._type_definition._enum_list[2]                 ).to eq :DONE_STATE
    end

    it "sig3_decl = body._signal_declaration(  'sig3', 'STATE_TYPE', nil, 'IDLE_STATE')" do
      expect(sig3_decl.class                                          ).to eq RbVHDL::Ast::Declaration::Signal
      expect(sig3_decl._owner                                         ).to eq body
      expect(sig3_decl._identifier_list.size                          ).to eq 1
      expect(sig3_decl._identifier_list[0].class                      ).to eq RbVHDL::Ast::Identifier
      expect(sig3_decl._identifier_list[0]                            ).to eq :sig3
      expect(sig3_decl._subtype_indication.class                      ).to eq RbVHDL::Ast::Type::Indication
      expect(sig3_decl._subtype_indication._type_mark.class           ).to eq RbVHDL::Ast::Type::Mark
      expect(sig3_decl._subtype_indication._type_mark                 ).to eq :STATE_TYPE
      expect(sig3_decl._subtype_indication._constraint                ).to eq nil
      expect(sig3_decl._mode                                          ).to eq nil
      expect(sig3_decl._value_expression.class                        ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(sig3_decl._value_expression._name.class                  ).to eq RbVHDL::Ast::Identifier
      expect(sig3_decl._value_expression._name                        ).to eq :IDLE_STATE
    end
    
end  
