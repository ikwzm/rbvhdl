require "spec_helper"

describe 'RbVHDL::Ast::Statement::ProcedureCall' do

  context "new" do

    it "new(nil)" do
      stmt = RbVHDL::Ast::Statement::ProcedureCall.new(nil, RbVHDL::Ast.name('proc'))
      expect(stmt.class                      ).to eq RbVHDL::Ast::Statement::ProcedureCall
      expect(stmt._owner                     ).to eq nil
      expect(stmt._label                     ).to eq nil
      expect(stmt._postponed                 ).to eq nil
      expect(stmt._parameter_association_list).to eq []
    end

    it "RbVHDL::Ast.procedure_call(nil, 'proc')._label!('PROC_0')" do
      stmt = RbVHDL::Ast.procedure_call(nil, 'proc')._label!('PROC_0')
      expect(stmt.class                      ).to eq RbVHDL::Ast::Statement::ProcedureCall
      expect(stmt._owner                     ).to eq nil
      expect(stmt._label.class               ).to eq RbVHDL::Ast::Label
      expect(stmt._label                     ).to eq :PROC_0
      expect(stmt._postponed                 ).to eq nil
      expect(stmt._parameter_association_list).to eq []
    end
    
  end

  context "_postponed!" do
    it "RbVHDL::Ast.procedure_call(nil, 'proc')._postponed!._label!('PROC_0')" do
      stmt = RbVHDL::Ast.procedure_call(nil, 'proc')._postponed!._label!('PROC_0')
      expect(stmt.class                      ).to eq RbVHDL::Ast::Statement::ProcedureCall
      expect(stmt._owner                     ).to eq nil
      expect(stmt._label.class               ).to eq RbVHDL::Ast::Label
      expect(stmt._label                     ).to eq :PROC_0
      expect(stmt._postponed                 ).to eq true
      expect(stmt._parameter_association_list).to eq []
    end
  end

  context "_parameter_association" do
    it "RbVHDL::Ast.procedure_call(nil, 'proc')" do
      stmt = RbVHDL::Ast.procedure_call(nil, 'proc')
      stmt._parameter_association(RbVHDL::Ast.name('param0'), RbVHDL::Ast.name('arg0'))
      stmt._parameter_association(RbVHDL::Ast.name('param1'), RbVHDL::Ast.decimal_literal(32))
      stmt._parameter_association(RbVHDL::Ast.name('param2'), RbVHDL::Ast.association_actual_open)
      stmt._parameter_association(RbVHDL::Ast.name('param3')._to(RbVHDL::Ast.decimal_literal(3), RbVHDL::Ast.decimal_literal(7)),
                                  RbVHDL::Ast.name('arg3'  )._to(RbVHDL::Ast.decimal_literal(0), RbVHDL::Ast.decimal_literal(3)))
      stmt._parameter_association(RbVHDL::Ast.name('param4')._index(RbVHDL::Ast.decimal_literal(0)),
                                  RbVHDL::Ast.name('arg4'  )._index(RbVHDL::Ast.decimal_literal(8)))
      expect(stmt.class                            ).to eq RbVHDL::Ast::Statement::ProcedureCall
      expect(stmt._owner                           ).to eq nil
      expect(stmt._label                           ).to eq nil
      expect(stmt._postponed                       ).to eq nil
      expect(stmt._parameter_association_list.size ).to eq 5

      expect(stmt._parameter_association_list[0]._formal_part.class                        ).to eq RbVHDL::Ast::Association::FormalName
      expect(stmt._parameter_association_list[0]._formal_part._name.class                  ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[0]._formal_part._name._name                  ).to eq :param0
      expect(stmt._parameter_association_list[0]._actual_part.class                        ).to eq RbVHDL::Ast::Association::ActualName
      expect(stmt._parameter_association_list[0]._actual_part._name.class                  ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[0]._actual_part._name._name                  ).to eq :arg0

      expect(stmt._parameter_association_list[1]._formal_part.class                        ).to eq RbVHDL::Ast::Association::FormalName
      expect(stmt._parameter_association_list[1]._formal_part._name.class                  ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[1]._formal_part._name._name                  ).to eq :param1
      expect(stmt._parameter_association_list[1]._actual_part.class                        ).to eq RbVHDL::Ast::Association::ActualExpression
      expect(stmt._parameter_association_list[1]._actual_part._expression.class            ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._parameter_association_list[1]._actual_part._expression._integer         ).to eq 32

      expect(stmt._parameter_association_list[2]._formal_part.class                        ).to eq RbVHDL::Ast::Association::FormalName
      expect(stmt._parameter_association_list[2]._formal_part._name.class                  ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[2]._formal_part._name._name                  ).to eq :param2
      expect(stmt._parameter_association_list[2]._actual_part.class                        ).to eq RbVHDL::Ast::Association::ActualOpen

      expect(stmt._parameter_association_list[3]._formal_part.class                        ).to eq RbVHDL::Ast::Association::FormalName
      expect(stmt._parameter_association_list[3]._formal_part._name.class                  ).to eq RbVHDL::Ast::Expression::SliceName
      expect(stmt._parameter_association_list[3]._formal_part._name._prefix.class          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[3]._formal_part._name._prefix._name          ).to eq :param3
      expect(stmt._parameter_association_list[3]._formal_part._name._range.class           ).to eq RbVHDL::Ast::Type::RangeTo
      expect(stmt._parameter_association_list[3]._formal_part._name._range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._parameter_association_list[3]._formal_part._name._range._l_expr._integer).to eq 3
      expect(stmt._parameter_association_list[3]._formal_part._name._range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._parameter_association_list[3]._formal_part._name._range._r_expr._integer).to eq 7
      expect(stmt._parameter_association_list[3]._actual_part.class                        ).to eq RbVHDL::Ast::Association::ActualName
      expect(stmt._parameter_association_list[3]._actual_part._name.class                  ).to eq RbVHDL::Ast::Expression::SliceName
      expect(stmt._parameter_association_list[3]._actual_part._name._prefix.class          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[3]._actual_part._name._prefix._name          ).to eq :arg3
      expect(stmt._parameter_association_list[3]._actual_part._name._range.class           ).to eq RbVHDL::Ast::Type::RangeTo
      expect(stmt._parameter_association_list[3]._actual_part._name._range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._parameter_association_list[3]._actual_part._name._range._l_expr._integer).to eq 0
      expect(stmt._parameter_association_list[3]._actual_part._name._range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._parameter_association_list[3]._actual_part._name._range._r_expr._integer).to eq 3

      expect(stmt._parameter_association_list[4]._formal_part.class                        ).to eq RbVHDL::Ast::Association::FormalName
      expect(stmt._parameter_association_list[4]._formal_part._name.class                  ).to eq RbVHDL::Ast::Expression::IndexedName
      expect(stmt._parameter_association_list[4]._formal_part._name._prefix.class          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[4]._formal_part._name._prefix._name          ).to eq :param4
      expect(stmt._parameter_association_list[4]._formal_part._name._index_list.size       ).to eq 1
      expect(stmt._parameter_association_list[4]._formal_part._name._index_list[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._parameter_association_list[4]._formal_part._name._index_list[0]._integer).to eq 0
      expect(stmt._parameter_association_list[4]._actual_part.class                        ).to eq RbVHDL::Ast::Association::ActualName
      expect(stmt._parameter_association_list[4]._actual_part._name.class                  ).to eq RbVHDL::Ast::Expression::IndexedName
      expect(stmt._parameter_association_list[4]._actual_part._name._prefix.class          ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._parameter_association_list[4]._actual_part._name._prefix._name          ).to eq :arg4
      expect(stmt._parameter_association_list[4]._actual_part._name._index_list.size       ).to eq 1
      expect(stmt._parameter_association_list[4]._actual_part._name._index_list[0].class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._parameter_association_list[4]._actual_part._name._index_list[0]._integer).to eq 8
    end
  end
end
