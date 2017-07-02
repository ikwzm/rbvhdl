require "spec_helper"

describe 'RbVHDL::Ast::Declaration::ProcedureDecl' do

  context "new" do

    it "new(nil, identifier('proc'))" do
      proc = RbVHDL::Ast::Declaration::ProcedureDecl.new(nil, RbVHDL::Ast.identifier('proc'))

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureDecl
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._parameter_interface_list).to eq []
    end

    it "new(nil, identifier('proc')){...}" do
    
      proc = RbVHDL::Ast::Declaration::ProcedureDecl.new(nil, RbVHDL::Ast.identifier('proc')) {
        _parameter_interface(       'param0', RbVHDL::Ast.subtype_indication('integer'         ), nil , 8  )
        _parameter_signal_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), :In , nil)
        _parameter_signal_interface('param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), :Out, nil)
      }

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureDecl
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._parameter_interface_list.size                                   ).to eq 3

      expect(proc._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(proc._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(proc._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(proc._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[0]._mode                               ).to eq nil
      expect(proc._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(proc._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(proc._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(proc._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[1]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::In
      expect(proc._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(proc._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(proc._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[2]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::Out
      expect(proc._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

  context "RbVHDL::Ast.procedure_declaration" do

    it "procedure_declaration(nil, 'proc')" do
      proc = RbVHDL::Ast.procedure_declaration(nil, 'proc')

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureDecl
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._parameter_interface_list).to eq []
    end

    it "procedure_declaration(nil, 'proc'){...}" do
    
      proc = RbVHDL::Ast.procedure_declaration(nil, 'proc') {
        _parameter_interface(       'param0', RbVHDL::Ast.subtype_indication('integer'         ), nil , 8  )
        _parameter_signal_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), :In , nil)
        _parameter_signal_interface('param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), :Out, nil)
      }

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureDecl
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._parameter_interface_list.size                                   ).to eq 3

      expect(proc._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(proc._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(proc._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(proc._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[0]._mode                               ).to eq nil
      expect(proc._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(proc._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(proc._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(proc._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[1]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::In
      expect(proc._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(proc._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(proc._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[2]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::Out
      expect(proc._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
  
end
      
describe 'RbVHDL::Ast::Declaration::ProcedureBody' do

  context "new" do

    it "new(nil, identifier('proc'))" do
      proc = RbVHDL::Ast::Declaration::ProcedureBody.new(nil, RbVHDL::Ast.identifier('proc'))

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureBody
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._parameter_interface_list).to eq []
      expect(proc._declarative_item_list   ).to eq []
      expect(proc._statement_list          ).to eq []
    end

    it "new(nil, identifier('proc')){...}" do
    
      proc = RbVHDL::Ast::Declaration::ProcedureBody.new(nil, RbVHDL::Ast.identifier('proc')) {
        _parameter_interface(       'param0', RbVHDL::Ast.subtype_indication('integer'         ), nil , 8  )
        _parameter_signal_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), :In , nil)
        _parameter_signal_interface('param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), :Out, nil)
        _variable_assignment_statement(RbVHDL::Ast.name('param2'), RbVHDL::Ast.name('param1'))
      }

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureBody
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._declarative_item_list   ).to eq []
      expect(proc._parameter_interface_list.size                                   ).to eq 3

      expect(proc._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(proc._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(proc._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(proc._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[0]._mode                               ).to eq nil
      expect(proc._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(proc._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(proc._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(proc._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[1]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::In
      expect(proc._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(proc._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(proc._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[2]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::Out
      expect(proc._parameter_interface_list[2]._static_expression                  ).to eq nil

      expect(proc._statement_list.size                                             ).to eq 1
      expect(proc._statement_list[0].class                                         ).to eq RbVHDL::Ast::Statement::SimpleVariableAssignment
      expect(proc._statement_list[0]._target.class                                 ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._statement_list[0]._target._name                                 ).to eq :param2
      expect(proc._statement_list[0]._value.class                                  ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._statement_list[0]._value._name                                  ).to eq :param1
    end
  end

  context "RbVHDL::Ast.procedure_body" do

    it "procedure_body(nil, 'proc')" do
      proc = RbVHDL::Ast.procedure_body(nil, 'proc')

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureBody
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._parameter_interface_list).to eq []
      expect(proc._declarative_item_list   ).to eq []
      expect(proc._statement_list          ).to eq []
    end

    it "procedure_body(nil, 'proc'){...}" do
    
      proc = RbVHDL::Ast.procedure_body(nil, 'proc') {
        _parameter_interface(       'param0', RbVHDL::Ast.subtype_indication('integer'         ), nil , 8  )
        _parameter_signal_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), :In , nil)
        _parameter_signal_interface('param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), :Out, nil)
      }

      expect(proc.class                    ).to eq RbVHDL::Ast::Declaration::ProcedureBody
      expect(proc._owner                   ).to eq nil
      expect(proc._identifier              ).to eq :proc
      expect(proc._generic_interface_list  ).to eq []
      expect(proc._generic_association_list).to eq []
      expect(proc._annotation              ).to eq Hash.new
      expect(proc._declarative_item_list   ).to eq []
      expect(proc._statement_list          ).to eq []
      expect(proc._parameter_interface_list.size                                   ).to eq 3

      expect(proc._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(proc._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(proc._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(proc._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[0]._mode                               ).to eq nil
      expect(proc._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(proc._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(proc._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(proc._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[1]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::In
      expect(proc._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(proc._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(proc._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(proc._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(proc._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(proc._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(proc._parameter_interface_list[2]._mode.class                         ).to eq RbVHDL::Ast::Interface::Mode::Out
      expect(proc._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

describe 'RbVHDL::Ast::Declaration::FunctionDecl' do

  context "new" do
    
    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic'))" do
      func = RbVHDL::Ast::Declaration::FunctionDecl.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic'))
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic')){...}" do
      func = RbVHDL::Ast::Declaration::FunctionDecl.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic')){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

  context "RbVHDL::Ast.function_declaration" do

    it "function_declaration(nil, 'func', 'std_logic')" do
      func = RbVHDL::Ast.function_declaration(nil, 'func', 'std_logic')
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "function_declaration(nil, 'func', 'std_logic'){...}" do
      func = RbVHDL::Ast.function_declaration(nil, 'func', 'std_logic'){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

describe 'RbVHDL::Ast::Declaration::FunctionBody' do

  context "new" do
    
    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic'))" do
      func = RbVHDL::Ast::Declaration::FunctionBody.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic'))
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic')){...}" do
      func = RbVHDL::Ast::Declaration::FunctionBody.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic')){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

  context "RbVHDL::Ast.function_body" do

    it "function_body(nil, 'func', 'std_logic')" do
      func = RbVHDL::Ast.function_body(nil, 'func', 'std_logic')
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "function_body(nil, 'func', 'std_logic'){...}" do
      func = RbVHDL::Ast.function_body(nil, 'func', 'std_logic'){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::FunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

describe 'RbVHDL::Ast::Declaration::PureFunctionDecl' do

  context "new" do
    
    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic'))" do
      func = RbVHDL::Ast::Declaration::PureFunctionDecl.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic'))
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic')){...}" do
      func = RbVHDL::Ast::Declaration::PureFunctionDecl.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic')){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

  context "RbVHDL::Ast.pure_function_declaration" do

    it "pure_function_declaration(nil, 'func', 'std_logic')" do
      func = RbVHDL::Ast.pure_function_declaration(nil, 'func', 'std_logic')
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "pure_function_declaration(nil, 'func', 'std_logic'){...}" do
      func = RbVHDL::Ast.pure_function_declaration(nil, 'func', 'std_logic'){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

describe 'RbVHDL::Ast::Declaration::PureFunctionBody' do

  context "new" do
    
    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic'))" do
      func = RbVHDL::Ast::Declaration::PureFunctionBody.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic'))
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic')){...}" do
      func = RbVHDL::Ast::Declaration::PureFunctionBody.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic')){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

  context "RbVHDL::Ast.pure_function_body" do

    it "pure_function_body(nil, 'func', 'std_logic')" do
      func = RbVHDL::Ast.pure_function_body(nil, 'func', 'std_logic')
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "pure_function_body(nil, 'func', 'std_logic'){...}" do
      func = RbVHDL::Ast.pure_function_body(nil, 'func', 'std_logic'){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::PureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

describe 'RbVHDL::Ast::Declaration::ImpureFunctionDecl' do

  context "new" do
    
    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic'))" do
      func = RbVHDL::Ast::Declaration::ImpureFunctionDecl.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic'))
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic')){...}" do
      func = RbVHDL::Ast::Declaration::ImpureFunctionDecl.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic')){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

  context "RbVHDL::Ast.impure_function_declaration" do

    it "impure_function_declaration(nil, 'func', 'std_logic')" do
      func = RbVHDL::Ast.impure_function_declaration(nil, 'func', 'std_logic')
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "impure_function_declaration(nil, 'func', 'std_logic'){...}" do
      func = RbVHDL::Ast.impure_function_declaration(nil, 'func', 'std_logic'){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionDecl
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

describe 'RbVHDL::Ast::Declaration::ImpureFunctionBody' do

  context "new" do
    
    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic'))" do
      func = RbVHDL::Ast::Declaration::ImpureFunctionBody.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic'))
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "new(nil, identifier('func'), RbVHDL::Ast.type_mark('std_logic')){...}" do
      func = RbVHDL::Ast::Declaration::ImpureFunctionBody.new(nil, RbVHDL::Ast.identifier('func'), RbVHDL::Ast.type_mark('std_logic')){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end

  context "RbVHDL::Ast.impure_function_body" do

    it "impure_function_body(nil, 'func', 'std_logic')" do
      func = RbVHDL::Ast.impure_function_body(nil, 'func', 'std_logic')
      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list).to eq []
    end

    it "impure_function_body(nil, 'func', 'std_logic'){...}" do
      func = RbVHDL::Ast.impure_function_body(nil, 'func', 'std_logic'){
        _parameter_interface(         'param0', RbVHDL::Ast.subtype_indication('integer'         ), 8  )
        _parameter_variable_interface('param1', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
        _parameter_signal_interface(  'param2', RbVHDL::Ast.subtype_indication('std_logic_vector'), nil)
      }

      expect(func.class                    ).to eq RbVHDL::Ast::Declaration::ImpureFunctionBody
      expect(func._owner                   ).to eq nil
      expect(func._identifier              ).to eq :func
      expect(func._generic_interface_list  ).to eq []
      expect(func._generic_association_list).to eq []
      expect(func._annotation              ).to eq Hash.new
      expect(func._type_mark.class         ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._type_mark._name         ).to eq :std_logic
      expect(func._parameter_interface_list.size                                   ).to eq 3

      expect(func._parameter_interface_list[0].class                               ).to eq RbVHDL::Ast::Interface
      expect(func._parameter_interface_list[0]._identifier_list                    ).to eq [:param0]
      expect(func._parameter_interface_list[0]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[0]._subtype_indication._type_mark._name).to eq :integer
      expect(func._parameter_interface_list[0]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[0]._mode                               ).to eq nil
      expect(func._parameter_interface_list[0]._static_expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(func._parameter_interface_list[0]._static_expression._integer         ).to eq 8

      expect(func._parameter_interface_list[1].class                               ).to eq RbVHDL::Ast::Interface::Variable
      expect(func._parameter_interface_list[1]._identifier_list                    ).to eq [:param1]
      expect(func._parameter_interface_list[1]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[1]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[1]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[1]._mode                               ).to eq nil
      expect(func._parameter_interface_list[1]._static_expression                  ).to eq nil

      expect(func._parameter_interface_list[2].class                               ).to eq RbVHDL::Ast::Interface::Signal
      expect(func._parameter_interface_list[2]._identifier_list                    ).to eq [:param2]
      expect(func._parameter_interface_list[2]._subtype_indication.class           ).to eq RbVHDL::Ast::Type::Indication
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark.class).to eq RbVHDL::Ast::Expression::SimpleName
      expect(func._parameter_interface_list[2]._subtype_indication._type_mark._name).to eq :std_logic_vector
      expect(func._parameter_interface_list[2]._subtype_indication._constraint     ).to eq nil
      expect(func._parameter_interface_list[2]._mode                               ).to eq nil
      expect(func._parameter_interface_list[2]._static_expression                  ).to eq nil
    end
  end
end

