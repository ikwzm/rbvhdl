require "spec_helper"

describe 'RbVHDL::Ast::Expression::Name' do

  describe 'SimpleName' do
    context "new" do

      it "name('simple_name_0')" do
        name = RbVHDL::Ast.name('simple_name_0')
        expect(name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name).to eq :simple_name_0
      end

      it "name(:simple_name_1)" do
        name = RbVHDL::Ast.name(:simple_name_1)
        expect(name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name).to eq :simple_name_1
      end
      
      it "name(name(:simple_name_2))" do
        name = RbVHDL::Ast.name(RbVHDL::Ast.name(:simple_name_2))
        expect(name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name).to eq :simple_name_2
      end
    end
  end

  describe 'IndexedName' do
    context "new" do

      it "name('indexed_name_0')._index(RbVHDL::Ast.name(:expression))" do
        name = RbVHDL::Ast.name('indexed_name_0')._index(RbVHDL::Ast.name(:expression))
        expect(name.class               ).to eq RbVHDL::Ast::Expression::IndexedName
        expect(name._prefix.class       ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._name       ).to eq :indexed_name_0
        expect(name._index_list.size    ).to eq 1
        expect(name._index_list[0].class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._index_list[0]._name).to eq :expression
      end

      it "name('indexed_name_1')._index([RbVHDL::Ast.name(:expression0), RbVHDL::Ast.name(:expression1)])" do
        name = RbVHDL::Ast.name('indexed_name_1')._index([RbVHDL::Ast.name(:expression0), RbVHDL::Ast.name(:expression1)])
        expect(name.class               ).to eq RbVHDL::Ast::Expression::IndexedName
        expect(name._prefix.class       ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._name       ).to eq :indexed_name_1
        expect(name._index_list.size    ).to eq 2
        expect(name._index_list[0].class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._index_list[0]._name).to eq :expression0
        expect(name._index_list[1].class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._index_list[1]._name).to eq :expression1
      end

      it "name('indexed_name_2')._index(RbVHDL::Ast.name((expression2))._index(RbVHDL::Ast.name(expression3))" do
        name = RbVHDL::Ast.name('indexed_name_2')._index(RbVHDL::Ast.name(:expression2))._index(RbVHDL::Ast.name(:expression3))
        expect(name.class                       ).to eq RbVHDL::Ast::Expression::IndexedName
        expect(name._prefix.class               ).to eq RbVHDL::Ast::Expression::IndexedName
        expect(name._prefix._prefix.class       ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._prefix._name       ).to eq :indexed_name_2
        expect(name._prefix._index_list.size    ).to eq 1
        expect(name._prefix._index_list[0].class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._index_list[0]._name).to eq :expression2
        expect(name._index_list.size            ).to eq 1
        expect(name._index_list[0].class        ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._index_list[0]._name        ).to eq :expression3
      end
    end
  end

  describe 'SliceName' do
    context "new" do

      it "name('slice_name_0')._slice(range_attr(name('slice_type')._attribute('range')))" do
        name      = RbVHDL::Ast.name('slice_name_0')._slice(RbVHDL::Ast.range_attr(RbVHDL::Ast.name('slice_type')._attribute('range')))
        expect(name.class                         ).to eq RbVHDL::Ast::Expression::SliceName
        expect(name._prefix.class                 ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._name                 ).to eq :slice_name_0
        expect(name._range.class                  ).to eq RbVHDL::Ast::Type::RangeAttribute
        expect(name._range._name.class            ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(name._range._name._name.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._range._name._name._name      ).to eq :slice_type
        expect(name._range._name._attribute       ).to eq :range
      end      

      it "name('slice_name_1')._to(0,5)" do
        name = RbVHDL::Ast.name('slice_name_1')._to(0, 5)
        expect(name.class                         ).to eq RbVHDL::Ast::Expression::SliceName
        expect(name._prefix.class                 ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._name                 ).to eq :slice_name_1
        expect(name._range.class                  ).to eq RbVHDL::Ast::Type::RangeTo
        expect(name._range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(name._range._l_expr._integer       ).to eq 0
        expect(name._range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(name._range._r_expr._integer       ).to eq 5
      end

      it "name('slice_name_2')._downto(7,4)" do
        name = RbVHDL::Ast.name('slice_name_2')._downto(7, 4)
        expect(name.class                         ).to eq RbVHDL::Ast::Expression::SliceName
        expect(name._prefix.class                 ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._name                 ).to eq :slice_name_2
        expect(name._range.class                  ).to eq RbVHDL::Ast::Type::RangeDownto
        expect(name._range._l_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(name._range._l_expr._integer       ).to eq 7
        expect(name._range._r_expr.class          ).to eq RbVHDL::Ast::Expression::DecimalLiteral
        expect(name._range._r_expr._integer       ).to eq 4
      end
    end
  end

  describe 'SelectedName' do
    context "new" do
  
      it "name('library_name')._select('package_name')" do
        name = RbVHDL::Ast.name('library_name')._select('package_name')
        expect(name.class                      ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix.class              ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._name              ).to eq :library_name
        expect(name._suffix.class              ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._suffix._name              ).to eq :package_name
      end

      it "name('library_name')._select('package_name')._select('component_name')" do
        name = RbVHDL::Ast.name('library_name')._select('package_name')._select('component_name')
        expect(name.class                      ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix.class              ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix._prefix.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._prefix._name      ).to eq :library_name
        expect(name._prefix._suffix.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._suffix._name      ).to eq :package_name
        expect(name._suffix.class              ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._suffix._name              ).to eq :component_name
      end

      it "name('library_name')._select(name('package_name'))" do
        name = RbVHDL::Ast.name('library_name')._select(RbVHDL::Ast.name('package_name'))
        expect(name.class                      ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix.class              ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._name              ).to eq :library_name
        expect(name._suffix.class              ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._suffix._name              ).to eq :package_name
      end

      it "name('library_name')._select(name('package_name'))._select(name('component_name'))" do
        name = RbVHDL::Ast.name('library_name')._select(RbVHDL::Ast.name('package_name'))._select(RbVHDL::Ast.name('component_name'))
        expect(name.class                      ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix.class              ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix._prefix.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._prefix._name      ).to eq :library_name
        expect(name._prefix._suffix.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._suffix._name      ).to eq :package_name
        expect(name._suffix.class              ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._suffix._name              ).to eq :component_name
      end

      it "name('library_name')._select(name('package_name'))._select_all" do
        name = RbVHDL::Ast.name('library_name')._select(RbVHDL::Ast.name('package_name'))._select_all
        expect(name.class                      ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix.class              ).to eq RbVHDL::Ast::Expression::SelectedName
        expect(name._prefix._prefix.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._prefix._name      ).to eq :library_name
        expect(name._prefix._suffix.class      ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._prefix._suffix._name      ).to eq :package_name
        expect(name._suffix.class              ).to eq RbVHDL::Ast::Expression::All
      end
    end
  end
      
  describe 'FunctionCall' do
    context "new" do

      it "name('function_0')._call([])" do
        name = RbVHDL::Ast.name('function_0')._call([])
        expect(name.class                      ).to eq RbVHDL::Ast::Expression::FunctionCall
        expect(name._name.class                ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name._name                ).to eq :function_0
        expect(name._parameter_association_list).to eq []
      end

      it "name('function_1')._call(name(:param0))" do
        name = RbVHDL::Ast.name('function_1')._call(RbVHDL::Ast.name(:param0))
        expect(name.class                                                  ).to eq RbVHDL::Ast::Expression::FunctionCall
        expect(name._name.class                                            ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name._name                                            ).to eq :function_1
        expect(name._parameter_association_list.size                       ).to eq 1
        expect(name._parameter_association_list[0].class                   ).to eq RbVHDL::Ast::Association
        expect(name._parameter_association_list[0]._formal_part.class      ).to eq RbVHDL::Ast::Association::FormalIndex
        expect(name._parameter_association_list[0]._formal_part._index     ).to eq 0
        expect(name._parameter_association_list[0]._actual_part.class      ).to eq RbVHDL::Ast::Association::ActualName
        expect(name._parameter_association_list[0]._actual_part._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._parameter_association_list[0]._actual_part._name._name).to eq :param0
      end

      it "name('function_2')._call([name(:param0), name(:param1)])" do
        name = RbVHDL::Ast.name('function_2')._call([RbVHDL::Ast.name(:param0), RbVHDL::Ast.name(:param1)])
        expect(name.class                                                  ).to eq RbVHDL::Ast::Expression::FunctionCall
        expect(name._name.class                                            ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name._name                                            ).to eq :function_2
        expect(name._parameter_association_list.size                       ).to eq 2
        expect(name._parameter_association_list[0].class                   ).to eq RbVHDL::Ast::Association
        expect(name._parameter_association_list[0]._formal_part.class      ).to eq RbVHDL::Ast::Association::FormalIndex
        expect(name._parameter_association_list[0]._formal_part._index     ).to eq 0
        expect(name._parameter_association_list[0]._actual_part.class      ).to eq RbVHDL::Ast::Association::ActualName
        expect(name._parameter_association_list[0]._actual_part._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._parameter_association_list[0]._actual_part._name._name).to eq :param0
        expect(name._parameter_association_list[1].class                   ).to eq RbVHDL::Ast::Association
        expect(name._parameter_association_list[1]._formal_part.class      ).to eq RbVHDL::Ast::Association::FormalIndex
        expect(name._parameter_association_list[1]._formal_part._index     ).to eq 1
        expect(name._parameter_association_list[1]._actual_part.class      ).to eq RbVHDL::Ast::Association::ActualName
        expect(name._parameter_association_list[1]._actual_part._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._parameter_association_list[1]._actual_part._name._name).to eq :param1
      end

      it "name('function_3')._call({name(:arg0) => name(:param0), name(:arg1) => name(:param1)})" do
        name = RbVHDL::Ast.name('function_3')._call({RbVHDL::Ast.name(:arg0) => RbVHDL::Ast.name(:param0), RbVHDL::Ast.name(:arg1) => RbVHDL::Ast.name(:param1)})
        expect(name.class                                                  ).to eq RbVHDL::Ast::Expression::FunctionCall
        expect(name._name.class                                            ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name._name                                            ).to eq :function_3
        expect(name._parameter_association_list.size                       ).to eq 2
        expect(name._parameter_association_list[0].class                   ).to eq RbVHDL::Ast::Association
        expect(name._parameter_association_list[0]._formal_part.class      ).to eq RbVHDL::Ast::Association::FormalName
        expect(name._parameter_association_list[0]._formal_part._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._parameter_association_list[0]._formal_part._name._name).to eq :arg0
        expect(name._parameter_association_list[0]._actual_part.class      ).to eq RbVHDL::Ast::Association::ActualName
        expect(name._parameter_association_list[0]._actual_part._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._parameter_association_list[0]._actual_part._name._name).to eq :param0
        expect(name._parameter_association_list[1].class                   ).to eq RbVHDL::Ast::Association
        expect(name._parameter_association_list[1]._formal_part.class      ).to eq RbVHDL::Ast::Association::FormalName
        expect(name._parameter_association_list[1]._formal_part._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._parameter_association_list[1]._formal_part._name._name).to eq :arg1
        expect(name._parameter_association_list[1]._actual_part.class      ).to eq RbVHDL::Ast::Association::ActualName
        expect(name._parameter_association_list[1]._actual_part._name.class).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._parameter_association_list[1]._actual_part._name._name).to eq :param1
      end
    end
  end

  describe 'AttributeName' do
    context "new" do

      it "AttributeName.new(name('signal_0', 'range')" do
        name = RbVHDL::Ast::Expression::AttributeName.new(RbVHDL::Ast.name('signal_0'), RbVHDL::Ast.identifier("range"),  nil, nil)
        expect(name.class           ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(name._name.class     ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name._name     ).to eq :signal_0
        expect(name._attribute.class).to eq RbVHDL::Ast::Identifier
        expect(name._attribute      ).to eq :range
        expect(name._signature      ).to eq nil
        expect(name._expression     ).to eq nil
      end

      it "name('signal_1')._attribute('range')" do
        name = RbVHDL::Ast.name('signal_1')._attribute('range', nil, nil)
        expect(name.class           ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(name._name.class     ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name._name     ).to eq :signal_1
        expect(name._attribute.class).to eq RbVHDL::Ast::Identifier
        expect(name._attribute      ).to eq :range
        expect(name._signature      ).to eq nil
        expect(name._expression     ).to eq nil
      end

      it "name('signal_1')._attribute('range', nil, nil)" do
        name = RbVHDL::Ast.name('signal_1')._attribute('range', nil, nil)
        expect(name.class           ).to eq RbVHDL::Ast::Expression::AttributeName
        expect(name._name.class     ).to eq RbVHDL::Ast::Expression::SimpleName
        expect(name._name._name     ).to eq :signal_1
        expect(name._attribute.class).to eq RbVHDL::Ast::Identifier
        expect(name._attribute      ).to eq :range
        expect(name._signature      ).to eq nil
        expect(name._expression     ).to eq nil
      end
    end
  end
end

