require "spec_helper"

describe 'RbVHDL::Ast::Declaration::ProcedureDecl' do

  context "new" do

    it "procedure proc(param0: in integer;param1: in std_logic_vector; param2: out std_logic_vector);" do
      proc = RbVHDL::Ast::Declaration::ProcedureDecl.new(nil, 'proc')
      param0 = proc._parameter_interface(       'param0', RbVHDL::Ast.subtype_indication('integer'         ), nil , 8  )
      param1 = proc._parameter_signal_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), :In , nil)
      param2 = proc._parameter_signal_interface('param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), :Out, nil)

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureDecl
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._parameter_interface_list.size                                   ).to eq 3

      expect(proc._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(proc._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(proc._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark      ).to eq :integer
      expect(proc._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[0]._mode                               ).to eq nil
      expect(proc._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(proc._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(proc._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(proc._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark      ).to eq :std_logic_vector
      expect(proc._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[1]._mode                               ).to eq :In
      expect(proc._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(proc._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(proc._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark      ).to eq :std_logic_vector
      expect(proc._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[2]._mode                               ).to eq :Out
      expect(proc._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
    
  end
end
      
describe 'RbVHDL::Ast::Declaration::PureFuncionDecl' do

  context "new" do
    
    it "function func(param0: integer;param1: std_logic_vector; param2: std_logic_vector) return std_logic;" do
      func = RbVHDL::Ast::Declaration::PureFunctionDecl.new(nil, 'func', 'std_logic')
      param0 = func._parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
      param1 = func._parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      param2 = func._parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark      ).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark      ).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark      ).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

describe 'RbVHDL::Ast::Declaration::ImpureFuncionDecl' do

  context "new" do
    
    it "impure function func(param0: integer;param1: std_logic_vector; param2: std_logic_vector) return std_logic;" do
      func = RbVHDL::Ast::Declaration::ImpureFunctionDecl.new(nil, 'func', 'std_logic')
      param0 = func._parameter_interface('param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
      param1 = func._parameter_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      param2 = func._parameter_interface('param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark      ).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark      ).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Type::Mark
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark      ).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

end
