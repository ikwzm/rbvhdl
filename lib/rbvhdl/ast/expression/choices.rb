module RbVHDL::Ast

  class Expression
    #
    # choices   : choice
    #           | choice "|" choices
    #
    class Choices
      attr_reader   :_choice_list
      def initialize
        @_choice_list = []
      end
      def _add_choice(choice)
        if choice.class == Choices then
          @_choice_list.concat(choice._choice_list)
        else
          @_choice_list.push(choice)
        end
        return self
      end
    end
    #
    # choice    : simple_expression
    #
    class ChoiceExpression < Choices
      attr_reader   :_expression
      def initialize(expression)
        super()
        @_expression = expression
      end
    end
    #
    # choice    | descrete_range
    #
    class ChoiceRange < Choices
      attr_reader   :_range
      def initialize(range)
        super()
        @_range = range
      end
    end
    #
    # choice    | identifier
    #
    class ChoiceIdentifier < Choices
      attr_reader   :_name
      def initialize(name)
        super()
        @_name = name
      end
    end
    #
    # choice    | others
    #
    class ChoiceOthers < Choices
      def initialize
        super()
      end
    end

  end

  def self.choice_expression(expression)
    return RbVHDL::Ast::Expression::ChoiceExpression.new(RbVHDL::Ast.expression(expression))
  end

  def self.choice_range(range)
    return RbVHDL::Ast::Expression::ChoiceRange.new(range)
  end

  def self.choice_range_attr(name)
    return RbVHDL::Ast::Expression::ChoiceRange.new(RbVHDL::Ast.range_attr(name))
  end

  def self.choice_range_to(l,r)
    return RbVHDL::Ast::Expression::ChoiceRange.new(RbVHDL::Ast.range_to(l,r))
  end
    
  def self.choice_range_downto(l,r)
    return RbVHDL::Ast::Expression::ChoiceRange.new(RbVHDL::Ast.range_downto(l,r))
  end

  def self.choice_identifier(name)
    return RbVHDL::Ast::Expression::ChoiceIdentifier.new(RbVHDL::Ast.identifier(name))
  end

  def self.choice_others
    return RbVHDL::Ast::Expression::ChoiceOthers.new
  end

  def self.choice(choice)
    if    choice.class < RbVHDL::Ast::Expression::Choices then
      return choice
    elsif choice.class < RbVHDL::Ast::Expression  then
      return RbVHDL::Ast.choice_expression(choice)
    elsif choice.class < RbVHDL::Ast::Type::Range then
      return RbVHDL::Ast.choice_range(choice)
    else
      return RbVHDL::Ast.choice_identifier(choice)
    end
  end

  def self.choices(choices)
    if    choices.class < RbVHDL::Ast::Expression::Choices then
      return choices
    elsif choices.class == Array then
      new_choices = RbVHDL::Ast::Expression::Choices.new
      choices.each do |choice|
        new_choices._add_choice(RbVHDL::Ast.choice(choice))
      end
      return new_choices
    else
      return RbVHDL::Ast.choice(choice)
    end
  end
  
end
