require "spec_helper"

describe 'RbVHDL::Ast::Expression::Choice' do

  describe 'ChoiceExpression' do
    context "_write_string" do
      it do
        choice = RbVHDL::Ast.choice_expression(RbVHDL::Ast.expression(RbVHDL::Ast.name('sig1')._attribute('range')))
        string = choice._write_string({})
        expect(string).to eq "sig1'range"
      end
    end
  end

  describe 'ChoiceRange' do
    context "_write_string" do
      it do
        choice = RbVHDL::Ast.choice_range_to(0, 2)
        string = choice._write_string({})
        expect(string).to eq "0 to 2"
      end
      it do
        choice = RbVHDL::Ast.choice_range_downto(7, 0)
        string = choice._write_string({})
        expect(string).to eq "7 downto 0"
      end
    end
  end
    
  describe 'ChoiceIdentifier' do
    context "_write_string" do
      it do
        choice = RbVHDL::Ast.choice_identifier('sig1')
        string = choice._write_string({})
        expect(string).to eq "sig1"
      end
    end
  end
  
  describe 'ChoiceOthers' do
    context "_write_string" do
      it do
        choice = RbVHDL::Ast.choice_others
        string = choice._write_string({})
        expect(string).to eq "others"
      end
    end
  end
    
  describe 'Choices' do
    context "_write_string" do
      it do
        choice_list = [RbVHDL::Ast.name('sig1')._attribute('range'),
                       RbVHDL::Ast.range_to(0, 3),
                       RbVHDL::Ast.choice_expression(RbVHDL::Ast.name('sig2')._attribute('range')),
                       RbVHDL::Ast.choice_identifier('sig3'),
                       RbVHDL::Ast.choice_range_downto(7, 0),
                       RbVHDL::Ast.choice_others]
        choices = RbVHDL::Ast.choices(choice_list)
        string = choices._write_string({})
        expect(string).to eq "sig1'range | 0 to 3 | sig2'range | sig3 | 7 downto 0 | others"
      end
    end
  end
    
end
