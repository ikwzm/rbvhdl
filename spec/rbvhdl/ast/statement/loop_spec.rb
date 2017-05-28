require "spec_helper"

describe 'RbVHDL::Ast::Statement::Loop' do

  context "new" do

    it "new(nil)" do
      stmt = RbVHDL::Ast::Statement::Loop.new(nil)
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Loop
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label                 ).to eq nil
      expect(stmt._statement_list        ).to eq []
    end

    it "RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP')" do
      stmt = RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP')
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::Loop
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :TOP_LOOP
      expect(stmt._statement_list        ).to eq []
    end      

  end

  context "_next_statement" do

    it "RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP') .. _next_statement" do
      loop_stmt = RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP')
      next_stmt = loop_stmt._next_statement
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::Loop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq next_stmt
      expect(next_stmt.class                  ).to eq RbVHDL::Ast::Statement::Next
      expect(next_stmt._owner                 ).to eq loop_stmt
      expect(next_stmt._label                 ).to eq nil
      expect(next_stmt._next_label            ).to eq nil
      expect(next_stmt._condition             ).to eq nil
    end      
      
    it "RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP') .. _next_statement._label!('NEXT_LOOP')._next_label!('TOP_LOOP')._(name('next_cond'))" do
      loop_stmt = RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP')
      next_stmt = loop_stmt._next_statement._label!('NEXT_LOOP')._next_label!('TOP_LOOP')._when!(RbVHDL::Ast.name('next_cond'))
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::Loop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq next_stmt
      expect(next_stmt.class                  ).to eq RbVHDL::Ast::Statement::Next
      expect(next_stmt._owner                 ).to eq loop_stmt
      expect(next_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(next_stmt._label                 ).to eq :NEXT_LOOP
      expect(next_stmt._next_label.class      ).to eq RbVHDL::Ast::Label
      expect(next_stmt._next_label            ).to eq :TOP_LOOP
      expect(next_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(next_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(next_stmt._condition._name       ).to eq :next_cond
    end      
      
  end


  context "_exit_statement" do

    it "RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP') .. _exit_statement" do
      loop_stmt = RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP')
      exit_stmt = loop_stmt._exit_statement
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::Loop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq exit_stmt
      expect(exit_stmt.class                  ).to eq RbVHDL::Ast::Statement::Exit
      expect(exit_stmt._owner                 ).to eq loop_stmt
      expect(exit_stmt._label                 ).to eq nil
      expect(exit_stmt._exit_label            ).to eq nil
      expect(exit_stmt._condition             ).to eq nil
    end      
      
    it "RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP') .. _exit_statement._label!('EXIT_LOOP')._exit_label!('TOP_LOOP')._(name('exit_cond'))" do
      loop_stmt = RbVHDL::Ast.loop_statement(nil)._label!('TOP_LOOP')
      exit_stmt = loop_stmt._exit_statement._label!('EXIT_LOOP')._exit_label!('TOP_LOOP')._when!(RbVHDL::Ast.name('exit_cond'))
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::Loop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq exit_stmt
      expect(exit_stmt.class                  ).to eq RbVHDL::Ast::Statement::Exit
      expect(exit_stmt._owner                 ).to eq loop_stmt
      expect(exit_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(exit_stmt._label                 ).to eq :EXIT_LOOP
      expect(exit_stmt._exit_label.class      ).to eq RbVHDL::Ast::Label
      expect(exit_stmt._exit_label            ).to eq :TOP_LOOP
      expect(exit_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(exit_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(exit_stmt._condition._name       ).to eq :exit_cond
    end      
      
  end
end

describe 'RbVHDL::Ast::Statement::WhileLoop' do

  context "new" do

    it "new( name('cond0'))" do
      stmt = RbVHDL::Ast::Statement::WhileLoop.new(nil, RbVHDL::Ast.name('cond_0'))
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::WhileLoop
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label                 ).to eq nil
      expect(stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._condition._name       ).to eq :cond_0
      expect(stmt._statement_list        ).to eq []
    end

    it "RbVHDL::Ast.while_loop_statement(n name('cond_0'))._label!('TOP_LOOP')" do
      stmt = RbVHDL::Ast.while_loop_statement(nil,RbVHDL::Ast.name('cond_0'))._label!('TOP_LOOP')
      expect(stmt.class                  ).to eq RbVHDL::Ast::Statement::WhileLoop
      expect(stmt._owner                 ).to eq nil
      expect(stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(stmt._label                 ).to eq :TOP_LOOP
      expect(stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(stmt._condition._name       ).to eq :cond_0
      expect(stmt._statement_list        ).to eq []
    end      

  end

  context "_next_statement" do

    it "RbVHDL::Ast.while_loop_statement(nil, 'cond_0'))._label!('TOP_LOOP') .. _next_statement" do
      loop_stmt = RbVHDL::Ast.while_loop_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('TOP_LOOP')
      next_stmt = loop_stmt._next_statement
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::WhileLoop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(loop_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(loop_stmt._condition._name       ).to eq :cond_0
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq next_stmt
      expect(next_stmt.class                  ).to eq RbVHDL::Ast::Statement::Next
      expect(next_stmt._owner                 ).to eq loop_stmt
      expect(next_stmt._label                 ).to eq nil
      expect(next_stmt._next_label            ).to eq nil
      expect(next_stmt._condition             ).to eq nil
    end      
      
    it "RbVHDL::Ast.while_loop_statement(nil, 'cond_0'))._label!('TOP_LOOP') .. _next_statement._label!('NEXT_LOOP')._next_label!('TOP_LOOP')._when!(name('cond'))" do
      loop_stmt = RbVHDL::Ast.while_loop_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('TOP_LOOP')
      next_stmt = loop_stmt._next_statement._label!('NEXT_LOOP')._next_label!('TOP_LOOP')._when!(RbVHDL::Ast.name('next_cond'))
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::WhileLoop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(loop_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(loop_stmt._condition._name       ).to eq :cond_0
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq next_stmt
      expect(next_stmt.class                  ).to eq RbVHDL::Ast::Statement::Next
      expect(next_stmt._owner                 ).to eq loop_stmt
      expect(next_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(next_stmt._label                 ).to eq :NEXT_LOOP
      expect(next_stmt._next_label.class      ).to eq RbVHDL::Ast::Label
      expect(next_stmt._next_label            ).to eq :TOP_LOOP
      expect(next_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(next_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(next_stmt._condition._name       ).to eq :next_cond
    end
  end
      
  context "_exit_statement" do

    it "RbVHDL::Ast.while_loop_statement(nil, 'cond_0'))._label!('TOP_LOOP') .. _exit_statement" do
      loop_stmt = RbVHDL::Ast.while_loop_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('TOP_LOOP')
      exit_stmt = loop_stmt._exit_statement
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::WhileLoop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(loop_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(loop_stmt._condition._name       ).to eq :cond_0
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq exit_stmt
      expect(exit_stmt.class                  ).to eq RbVHDL::Ast::Statement::Exit
      expect(exit_stmt._owner                 ).to eq loop_stmt
      expect(exit_stmt._label                 ).to eq nil
      expect(exit_stmt._exit_label            ).to eq nil
      expect(exit_stmt._condition             ).to eq nil
    end      
      
    it "RbVHDL::Ast.while_loop_statement(nil, 'cond_0'))._label!('TOP_LOOP') .. _exit_statement._label!('EXIT_LOOP')._exit_label!('TOP_LOOP')._when!(name('cond'))" do
      loop_stmt = RbVHDL::Ast.while_loop_statement(nil, RbVHDL::Ast.name('cond_0'))._label!('TOP_LOOP')
      exit_stmt = loop_stmt._exit_statement._label!('EXIT_LOOP')._exit_label!('TOP_LOOP')._when!(RbVHDL::Ast.name('exit_cond'))
      expect(loop_stmt.class                  ).to eq RbVHDL::Ast::Statement::WhileLoop
      expect(loop_stmt._owner                 ).to eq nil
      expect(loop_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(loop_stmt._label                 ).to eq :TOP_LOOP
      expect(loop_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(loop_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(loop_stmt._condition._name       ).to eq :cond_0
      expect(loop_stmt._statement_list.size   ).to eq 1
      expect(loop_stmt._statement_list[0]     ).to eq exit_stmt
      expect(exit_stmt.class                  ).to eq RbVHDL::Ast::Statement::Exit
      expect(exit_stmt._owner                 ).to eq loop_stmt
      expect(exit_stmt._label.class           ).to eq RbVHDL::Ast::Label
      expect(exit_stmt._label                 ).to eq :EXIT_LOOP
      expect(exit_stmt._exit_label.class      ).to eq RbVHDL::Ast::Label
      expect(exit_stmt._exit_label            ).to eq :TOP_LOOP
      expect(exit_stmt._condition.class       ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(exit_stmt._condition._name.class ).to eq RbVHDL::Ast::Identifier
      expect(exit_stmt._condition._name       ).to eq :exit_cond
    end
      
  end
end

describe 'RbVHDL::Ast::Statement::ForLoop' do

  context "new" do

    it "new(nil, 'i', range_to(decimal_literal(0), decimal_literal(7)))" do
      stmt = RbVHDL::Ast::Statement::ForLoop.new(nil, RbVHDL::Ast.identifier('i'), RbVHDL::Ast.range_to(RbVHDL::Ast.decimal_literal(0), RbVHDL::Ast.decimal_literal(7)))
      expect(stmt.class                        ).to eq RbVHDL::Ast::Statement::ForLoop
      expect(stmt._owner                       ).to eq nil
      expect(stmt._label                       ).to eq nil
      expect(stmt._index_identifier.class      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._index_identifier            ).to eq :i
      expect(stmt._index_range.class           ).to eq RbVHDL::Ast::Type::RangeTo
      expect(stmt._index_range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._index_range._l_expr._integer).to eq 0
      expect(stmt._index_range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._index_range._r_expr._integer).to eq 7
      expect(stmt._statement_list              ).to eq []
    end

    it "RbVHDL::Ast.for_loop_statement(nil, identifier('i'), range_to(decimal_literal(0), decimal_literal(7)))._label!('TOP_LOOP')" do
      stmt = RbVHDL::Ast.for_loop_statement(nil, RbVHDL::Ast.identifier('i'), RbVHDL::Ast.range_to(RbVHDL::Ast.decimal_literal(0), RbVHDL::Ast.decimal_literal(7)))
      stmt._label!('TOP_LOOP')
      expect(stmt.class                        ).to eq RbVHDL::Ast::Statement::ForLoop
      expect(stmt._owner                       ).to eq nil
      expect(stmt._label.class                 ).to eq RbVHDL::Ast::Label
      expect(stmt._label                       ).to eq :TOP_LOOP
      expect(stmt._index_identifier.class      ).to eq RbVHDL::Ast::Identifier
      expect(stmt._index_identifier            ).to eq :i
      expect(stmt._index_range.class           ).to eq RbVHDL::Ast::Type::RangeTo
      expect(stmt._index_range._l_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._index_range._l_expr._integer).to eq 0
      expect(stmt._index_range._r_expr.class   ).to eq RbVHDL::Ast::Expression::DecimalLiteral
      expect(stmt._index_range._r_expr._integer).to eq 7
      expect(stmt._statement_list              ).to eq []
    end      
  end

      
end
