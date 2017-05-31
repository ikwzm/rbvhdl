require "spec_helper"

describe 'RbVHDL::Ast::Declaration::EnumerationType' do

  context "new" do

    it "new(nil, identifier('enum_type'), enumeration_type_definition(['S0','S1']))" do
      decl = RbVHDL::Ast::Declaration::EnumerationType.new(nil, RbVHDL::Ast.identifier('enum_type'), RbVHDL::Ast.enumeration_type_definition(['S0','S1']))
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::EnumerationType
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :enum_type
      expect(decl._type_definition.class              ).to eq RbVHDL::Ast::Type::EnumerationDefinition
      expect(decl._type_definition._enum_list.size    ).to eq 2
      expect(decl._type_definition._enum_list[0].class).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[0]      ).to eq :S0
      expect(decl._type_definition._enum_list[1].class).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[1]      ).to eq :S1
    end

    it "RbVHDL::Ast.enumeration_type_declaration(nil, 'enum_type', ['S0','S1'])" do
      decl = RbVHDL::Ast.enumeration_type_declaration(nil, 'enum_type', ['S0','S1'])
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::EnumerationType
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :enum_type
      expect(decl._type_definition.class              ).to eq RbVHDL::Ast::Type::EnumerationDefinition
      expect(decl._type_definition._enum_list.size    ).to eq 2
      expect(decl._type_definition._enum_list[0].class).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[0]      ).to eq :S0
      expect(decl._type_definition._enum_list[1].class).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[1]      ).to eq :S1
    end
  end

  context "_enum!" do
    it "RbVHDL::Ast.enumeration_type_declaration(nil, 'enum_type')._enum!('S0')._enum!('S1')" do
      decl = RbVHDL::Ast.enumeration_type_declaration(nil, 'enum_type')._enum!('S0')._enum!('S1')
      expect(decl.class                               ).to eq RbVHDL::Ast::Declaration::EnumerationType
      expect(decl._owner                              ).to eq nil
      expect(decl._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                         ).to eq :enum_type
      expect(decl._type_definition.class              ).to eq RbVHDL::Ast::Type::EnumerationDefinition
      expect(decl._type_definition._enum_list.size    ).to eq 2
      expect(decl._type_definition._enum_list[0].class).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[0]      ).to eq :S0
      expect(decl._type_definition._enum_list[1].class).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._enum_list[1]      ).to eq :S1
    end
  end
end

describe 'RbVHDL::Ast::Declaration::IntegerType' do

  context "new" do

    it "new(identifier('integer_type'), integer_type_definition(range_to(0, 255)))" do
      decl = RbVHDL::Ast::Declaration::IntegerType.new(nil, RbVHDL::Ast.identifier('integer_type'), RbVHDL::Ast.integer_type_definition(RbVHDL::Ast.range_to(0, 255)))
      expect(decl.class                                   ).to eq RbVHDL::Ast::Declaration::IntegerType
      expect(decl._owner                                  ).to eq nil
      expect(decl._identifier.class                       ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                             ).to eq :integer_type
      expect(decl._type_definition.class                  ).to eq RbVHDL::Ast::Type::IntegerDefinition
      expect(decl._type_definition._range.class           ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer).to eq 0
      expect(decl._type_definition._range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer).to eq 255
    end

    it "RbVHDL::Ast.integer_type_declaration(nil, 'integer_type', range_to(0, 255))" do
      decl = RbVHDL::Ast.integer_type_declaration(nil, 'integer_type', RbVHDL::Ast.range_to(0, 255))
      expect(decl._owner                                  ).to eq nil
      expect(decl._identifier.class                       ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                             ).to eq :integer_type
      expect(decl._type_definition.class                  ).to eq RbVHDL::Ast::Type::IntegerDefinition
      expect(decl._type_definition._range.class           ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer).to eq 0
      expect(decl._type_definition._range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer).to eq 255
    end

  end
end

describe 'RbVHDL::Ast::Declaration::FloatingType' do

  context "new" do

    it "new(identifier('integer_type'), floating_type_definition(range_to(0.0, 255.0)))" do
      decl = RbVHDL::Ast::Declaration::FloatingType.new(nil, RbVHDL::Ast.identifier('float_type'), RbVHDL::Ast.floating_type_definition(RbVHDL::Ast.range_to(0.0, 255.0)))
      expect(decl.class                                    ).to eq RbVHDL::Ast::Declaration::FloatingType
      expect(decl._owner                                   ).to eq nil
      expect(decl._identifier.class                        ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                              ).to eq :float_type
      expect(decl._type_definition.class                   ).to eq RbVHDL::Ast::Type::FloatingDefinition
      expect(decl._type_definition._range.class            ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range._l_expr.class    ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer ).to eq "0"
      expect(decl._type_definition._range._l_expr._fraction).to eq "0"
      expect(decl._type_definition._range._r_expr.class    ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer ).to eq "255"
      expect(decl._type_definition._range._r_expr._fraction).to eq "0"
    end

    it "RbVHDL::Ast.floating_type_declaration(nil, 'float_type', range_to(0.0, 255.0))" do
      decl = RbVHDL::Ast.floating_type_declaration(nil, 'float_type', RbVHDL::Ast.range_to(0.0, 255.0))
      expect(decl.class                                    ).to eq RbVHDL::Ast::Declaration::FloatingType
      expect(decl._owner                                   ).to eq nil
      expect(decl._identifier.class                        ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                              ).to eq :float_type
      expect(decl._type_definition.class                   ).to eq RbVHDL::Ast::Type::FloatingDefinition
      expect(decl._type_definition._range.class            ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range._l_expr.class    ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer ).to eq "0"
      expect(decl._type_definition._range._l_expr._fraction).to eq "0"
      expect(decl._type_definition._range._r_expr.class    ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer ).to eq "255"
      expect(decl._type_definition._range._r_expr._fraction).to eq "0"
    end
    
  end
end

describe 'RbVHDL::Ast::Declaration::PhysicalType' do

  context "new" do

    it "new(identifier('registance'), physical_type_definition(range_to(decimal_literal(0), decimal_literal(1),_exponent!(9)), identifier('ohm')))" do
      decl = RbVHDL::Ast::Declaration::PhysicalType.new(nil, RbVHDL::Ast.identifier('registance'), RbVHDL::Ast.physical_type_definition(RbVHDL::Ast.range_to(RbVHDL::Ast.decimal_literal(0), RbVHDL::Ast.decimal_literal(1)._exponent!(9)), RbVHDL::Ast.identifier('ohm')))
      expect(decl.class                                              ).to eq RbVHDL::Ast::Declaration::PhysicalType
      expect(decl._owner                                             ).to eq nil
      expect(decl._identifier.class                                  ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                        ).to eq :registance
      expect(decl._type_definition.class                             ).to eq RbVHDL::Ast::Type::PhysicalDefinition
      expect(decl._type_definition._range.class                      ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range._l_expr.class              ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer           ).to eq 0
      expect(decl._type_definition._range._r_expr.class              ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer           ).to eq 1
      expect(decl._type_definition._range._r_expr._exponent.class    ).to eq RbVHDL::Ast::Expression::Exponent
      expect(decl._type_definition._range._r_expr._exponent._number  ).to eq 9
      expect(decl._type_definition._range._r_expr._exponent._sign    ).to eq nil
      expect(decl._type_definition._unit.class                       ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._unit                             ).to eq :ohm
    end

    it "RbVHDL::Ast.physical_type_declaration(nil, 'registance', range_to(decimal_literal(0), decimal_literal(1)._exponent!(9)), 'ohm')" do
      decl = RbVHDL::Ast.physical_type_declaration(nil, 'registance', RbVHDL::Ast.range_to(RbVHDL::Ast.decimal_literal(0), RbVHDL::Ast.decimal_literal(1)._exponent!(9)), 'ohm')
      expect(decl.class                                              ).to eq RbVHDL::Ast::Declaration::PhysicalType
      expect(decl._owner                                             ).to eq nil
      expect(decl._identifier.class                                  ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                        ).to eq :registance
      expect(decl._type_definition.class                             ).to eq RbVHDL::Ast::Type::PhysicalDefinition
      expect(decl._type_definition._range.class                      ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range._l_expr.class              ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer           ).to eq 0
      expect(decl._type_definition._range._r_expr.class              ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer           ).to eq 1
      expect(decl._type_definition._range._r_expr._exponent.class    ).to eq RbVHDL::Ast::Expression::Exponent
      expect(decl._type_definition._range._r_expr._exponent._number  ).to eq 9
      expect(decl._type_definition._range._r_expr._exponent._sign    ).to eq nil
      expect(decl._type_definition._unit.class                       ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._unit                             ).to eq :ohm
    end

    it "RbVHDL::Ast.physical_type_declaration(nil, 'registance', range_to(decimal_literal(0), decimal_literal(1)._exponent!(9)), 'ohm', [...])" do
      decl = RbVHDL::Ast.physical_type_declaration(nil, 'registance', RbVHDL::Ast.range_to(RbVHDL::Ast.decimal_literal(0), RbVHDL::Ast.decimal_literal(1)._exponent!(9)), 'ohm', [['Kohm', RbVHDL::Ast.physical_literal(RbVHDL::Ast.decimal_literal(1000), 'ohm')],['Mohm', RbVHDL::Ast.decimal_literal(1000), 'Kohm']])
      expect(decl.class                                              ).to eq RbVHDL::Ast::Declaration::PhysicalType
      expect(decl._owner                                             ).to eq nil
      expect(decl._identifier.class                                  ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                        ).to eq :registance
      expect(decl._type_definition.class                             ).to eq RbVHDL::Ast::Type::PhysicalDefinition
      expect(decl._type_definition._range.class                      ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range._l_expr.class              ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._l_expr._integer           ).to eq 0
      expect(decl._type_definition._range._r_expr.class              ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range._r_expr._integer           ).to eq 1
      expect(decl._type_definition._range._r_expr._exponent.class    ).to eq RbVHDL::Ast::Expression::Exponent
      expect(decl._type_definition._range._r_expr._exponent._number  ).to eq 9
      expect(decl._type_definition._range._r_expr._exponent._sign    ).to eq nil
      expect(decl._type_definition._unit.class                       ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._unit                             ).to eq :ohm
      expect(decl._type_definition._unit_list.size                   ).to eq 2
      expect(decl._type_definition._unit_list[0].size                ).to eq 2
      expect(decl._type_definition._unit_list[0][0].class            ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._unit_list[0][0]                  ).to eq :Kohm
      expect(decl._type_definition._unit_list[0][1].class            ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
      expect(decl._type_definition._unit_list[0][1]._decimal.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._unit_list[0][1]._decimal._integer).to eq 1000
      expect(decl._type_definition._unit_list[0][1]._unit_name.class ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._type_definition._unit_list[0][1]._unit_name._name ).to eq :ohm
      expect(decl._type_definition._unit_list[1].size                ).to eq 2
      expect(decl._type_definition._unit_list[1][0].class            ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._unit_list[1][0]                  ).to eq :Mohm
      expect(decl._type_definition._unit_list[1][1].class            ).to eq RbVHDL::Ast::Expression::PhysicalLiteral
      expect(decl._type_definition._unit_list[1][1]._decimal.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._unit_list[1][1]._decimal._integer).to eq 1000
      expect(decl._type_definition._unit_list[1][1]._unit_name.class ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(decl._type_definition._unit_list[1][1]._unit_name._name ).to eq :Kohm
    end

  end
end

describe 'RbVHDL::Ast::Declaration::ArrayType' do

  context "new" do

    it "new(identifier('test_vector'), array_type_definition(range_to(0, 7), 'test_type'))" do
      decl = RbVHDL::Ast::Declaration::ArrayType.new(nil, RbVHDL::Ast.identifier('test_vector'), RbVHDL::Ast.array_type_definition(RbVHDL::Ast.range_to(0,7), 'test_type'))
      expect(decl.class                                                ).to eq RbVHDL::Ast::Declaration::ArrayType
      expect(decl._owner                                               ).to eq nil
      expect(decl._identifier.class                                    ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                          ).to eq :test_vector
      expect(decl._type_definition.class                               ).to eq RbVHDL::Ast::Type::ArrayDefinition
      expect(decl._type_definition._range_list.size                    ).to eq 1
      expect(decl._type_definition._range_list[0].class                ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range_list[0]._l_expr.class        ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range_list[0]._l_expr._integer     ).to eq 0
      expect(decl._type_definition._range_list[0]._r_expr.class        ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range_list[0]._r_expr._integer     ).to eq 7
      expect(decl._type_definition._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._subtype_indication._type_mark      ).to eq :test_type
    end

    it "RbVHDL::Ast.array_type_declaration(nil, 'test_vector', RbVHDL::Ast.range_to(0, 7), 'test_type')" do
      decl = RbVHDL::Ast.array_type_declaration(nil, 'test_vector', RbVHDL::Ast.range_to(0, 7), 'test_type')
      expect(decl.class                                                ).to eq RbVHDL::Ast::Declaration::ArrayType
      expect(decl._owner                                               ).to eq nil
      expect(decl._identifier.class                                    ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                          ).to eq :test_vector
      expect(decl._type_definition.class                               ).to eq RbVHDL::Ast::Type::ArrayDefinition
      expect(decl._type_definition._range_list.size                    ).to eq 1
      expect(decl._type_definition._range_list[0].class                ).to eq RbVHDL::Ast::Type::RangeTo
      expect(decl._type_definition._range_list[0]._l_expr.class        ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range_list[0]._l_expr._integer     ).to eq 0
      expect(decl._type_definition._range_list[0]._r_expr.class        ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(decl._type_definition._range_list[0]._r_expr._integer     ).to eq 7
      expect(decl._type_definition._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._subtype_indication._type_mark      ).to eq :test_type
    end

  end
end

describe 'RbVHDL::Ast::Declaration::RecordType' do

  context "new" do

    it "new(nil, identifier('data_type'), record_type_definition._field!('data0', subtype_indication('std_logic'))._field!('data1', subtype_indication('integer')))" do
      decl = RbVHDL::Ast::Declaration::RecordType.new(nil, RbVHDL::Ast.identifier('data_type'), RbVHDL::Ast.record_type_definition._field!('data0', RbVHDL::Ast.subtype_indication('std_logic'))._field!('data1', RbVHDL::Ast.subtype_indication('integer')))
      expect(decl.class                                                               ).to eq RbVHDL::Ast::Declaration::RecordType
      expect(decl._owner                                                              ).to eq nil
      expect(decl._identifier.class                                                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                                         ).to eq :data_type
      expect(decl._type_definition.class                                              ).to eq RbVHDL::Ast::Type::RecordDefinition
      expect(decl._type_definition._field_list.size                                   ).to eq 2
      expect(decl._type_definition._field_list[0].class                               ).to eq RbVHDL::Ast::Type::RecordDefinition::Field
      expect(decl._type_definition._field_list[0]._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._field_list[0]._identifier                         ).to eq :data0
      expect(decl._type_definition._field_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._field_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._field_list[0]._subtype_indication._type_mark      ).to eq :std_logic
      expect(decl._type_definition._field_list[1].class                               ).to eq RbVHDL::Ast::Type::RecordDefinition::Field
      expect(decl._type_definition._field_list[1]._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._field_list[1]._identifier                         ).to eq :data1
      expect(decl._type_definition._field_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._field_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._field_list[1]._subtype_indication._type_mark      ).to eq :integer
    end

    it "RbVHDL::Ast.record_type_declaration(nil, 'data_type', {'data0' => 'std_logic', 'data1' => 'integer'})" do
      decl = RbVHDL::Ast.record_type_declaration(nil, 'data_type', {'data0' => 'std_logic', 'data1' => 'integer'})
      expect(decl.class                                                               ).to eq RbVHDL::Ast::Declaration::RecordType
      expect(decl._owner                                                              ).to eq nil
      expect(decl._identifier.class                                                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                                         ).to eq :data_type
      expect(decl._type_definition.class                                              ).to eq RbVHDL::Ast::Type::RecordDefinition
      expect(decl._type_definition._field_list.size                                   ).to eq 2
      expect(decl._type_definition._field_list[0].class                               ).to eq RbVHDL::Ast::Type::RecordDefinition::Field
      expect(decl._type_definition._field_list[0]._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._field_list[0]._identifier                         ).to eq :data0
      expect(decl._type_definition._field_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._field_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._field_list[0]._subtype_indication._type_mark      ).to eq :std_logic
      expect(decl._type_definition._field_list[1].class                               ).to eq RbVHDL::Ast::Type::RecordDefinition::Field
      expect(decl._type_definition._field_list[1]._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._field_list[1]._identifier                         ).to eq :data1
      expect(decl._type_definition._field_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._field_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._field_list[1]._subtype_indication._type_mark      ).to eq :integer
    end
  end

  context "_field!" do
    it "RbVHDL::Ast.record_type_declaration(nil, 'data_type')._field!('data0', 'std_logic')._field!('data1', 'integer')" do
      decl = RbVHDL::Ast.record_type_declaration(nil, 'data_type')._field!('data0', 'std_logic')._field!('data1', 'integer')
      expect(decl.class                                                               ).to eq RbVHDL::Ast::Declaration::RecordType
      expect(decl._owner                                                              ).to eq nil
      expect(decl._identifier.class                                                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                                         ).to eq :data_type
      expect(decl._type_definition.class                                              ).to eq RbVHDL::Ast::Type::RecordDefinition
      expect(decl._type_definition._field_list.size                                   ).to eq 2
      expect(decl._type_definition._field_list[0].class                               ).to eq RbVHDL::Ast::Type::RecordDefinition::Field
      expect(decl._type_definition._field_list[0]._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._field_list[0]._identifier                         ).to eq :data0
      expect(decl._type_definition._field_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._field_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._field_list[0]._subtype_indication._type_mark      ).to eq :std_logic
      expect(decl._type_definition._field_list[1].class                               ).to eq RbVHDL::Ast::Type::RecordDefinition::Field
      expect(decl._type_definition._field_list[1]._identifier.class                   ).to eq RbVHDL::Ast::Identifier
      expect(decl._type_definition._field_list[1]._identifier                         ).to eq :data1
      expect(decl._type_definition._field_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._field_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._field_list[1]._subtype_indication._type_mark      ).to eq :integer
    end
  end
end

describe 'RbVHDL::Ast::Declaration::FileType' do

  context "new" do

    it "RbVHDL::Ast::Declaration::FileType.new(nil, identifier('file_type'), file_type_definition('string'))" do
      decl = RbVHDL::Ast::Declaration::FileType.new(nil, RbVHDL::Ast.identifier('file_type'), RbVHDL::Ast.file_type_definition('string'))
      expect(decl.class                            ).to eq RbVHDL::Ast::Declaration::FileType
      expect(decl._owner                           ).to eq nil
      expect(decl._identifier.class                ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                      ).to eq :file_type
      expect(decl._type_definition.class           ).to eq RbVHDL::Ast::Type::FileDefinition
      expect(decl._type_definition._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._type_mark      ).to eq :string
    end

    it "RbVHDL::Ast.file_type_declaration(nil, 'file_type', 'string')" do
      decl = RbVHDL::Ast.file_type_declaration(nil, 'file_type', 'string')
      expect(decl.class                            ).to eq RbVHDL::Ast::Declaration::FileType
      expect(decl._owner                           ).to eq nil
      expect(decl._identifier.class                ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                      ).to eq :file_type
      expect(decl._type_definition.class           ).to eq RbVHDL::Ast::Type::FileDefinition
      expect(decl._type_definition._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._type_mark      ).to eq :string
    end

  end
end

describe 'RbVHDL::Ast::Declaration::AccessType' do

  context "new" do

    it "new(nil, identifier('line'), access_type_definition('string'))" do
      decl = RbVHDL::Ast::Declaration::AccessType.new(nil, RbVHDL::Ast.identifier('line'), RbVHDL::Ast.access_type_definition('string'))
      expect(decl.class                                                ).to eq RbVHDL::Ast::Declaration::AccessType
      expect(decl._owner                                               ).to eq nil
      expect(decl._identifier.class                                    ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                          ).to eq :line
      expect(decl._type_definition.class                               ).to eq RbVHDL::Ast::Type::AccessDefinition
      expect(decl._type_definition._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._subtype_indication._type_mark      ).to eq :string
    end
    
    it "RbVHDL::Ast.access_type_declaration(nil, 'line', 'string')" do
      decl = RbVHDL::Ast.access_type_declaration(nil, 'line', 'string')
      expect(decl.class                                                ).to eq RbVHDL::Ast::Declaration::AccessType
      expect(decl._owner                                               ).to eq nil
      expect(decl._identifier.class                                    ).to eq RbVHDL::Ast::Identifier
      expect(decl._identifier                                          ).to eq :line
      expect(decl._type_definition.class                               ).to eq RbVHDL::Ast::Type::AccessDefinition
      expect(decl._type_definition._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(decl._type_definition._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(decl._type_definition._subtype_indication._type_mark      ).to eq :string
    end

  end
end

