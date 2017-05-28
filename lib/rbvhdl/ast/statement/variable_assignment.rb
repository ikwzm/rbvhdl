module RbVHDL::Ast

  module Statement

    class VariableAssignment
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_target

      def initialize(owner, target)
        @_owner  = owner
        @_label  = nil
        @_target = target
      end

      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end
    end

    class SimpleVariableAssignment      < VariableAssignment
      attr_accessor :_value

      def initialize(owner, target, value)
        super(owner, target)
        @_value = value
      end

    end
    
    class ConditionalVariableAssignment < VariableAssignment
      attr_reader   :_value_list

      def initialize(owner, target, value)
        super(owner, target)
        if value.nil? then
          @_value_list = []
        else
          @_value_list = [[value, nil]]
        end
      end

      def _when!(condition)
        @_value_list.last[1] = RbVHDL::Ast.expression(condition)
        return self
      end

      def _else!(value)
        @_value_list.push([RbVHDL::Ast.expression(value), nil])
        return self
      end
    end

    class SelectedVariableAssignment    < VariableAssignment
      attr_reader   :_value_list
      attr_accessor :_expression

      def initialize(owner, expression, target, value, choices)
        super(owner, target)
        @_expression = expression
        @_value_list = [[value, choices]]
      end

      def _when!(choices)
        @_value_list.last[1] = RbVHDL::Ast.choices(choices)
        return self
      end

      def _else!(value)
        @_value_list.push([RbVHDL::Ast.expression(value), nil])
        return self
      end
    end
  end

  def self.variable_assignment_target(target)
    if target.class < RbVHDL::Ast::Expression::Name or
       target.class < RbVHDL::Ast::Expression::Aggregate then
      return target
    else
      return RbVHDL::Ast.name(target)
    end
  end

  def self.simple_variable_assignment_statement(owner, target, value=nil)
    _target = RbVHDL::Ast.variable_assignment_target(target)
    _value  = RbVHDL::Ast.expression_or_nil(value)
    return RbVHDL::Ast::Statement::SimpleVariableAssignment.new(owner, _target, _value)
  end

  def self.conditional_variable_assignment_statement(owner, target, value=nil)
    _target = RbVHDL::Ast.variable_assignment_target(target)
    _value  = RbVHDL::Ast.expression_or_nil(value)
    return RbVHDL::Ast::Statement::ConditionalVariableAssignment.new(owner, _target, _value)
  end

  def self.selected_variable_assignment_statement(owner, expression, target, value, choices)
    _target     = RbVHDL::Ast.variable_assignment_target(target)
    _expression = RbVHDL::Ast.expression(expression)
    _value      = RbVHDL::Ast.expression_or_nil(value)
    _choices    = RbVHDL::Ast.choices(choices)
    return RbVHDL::Ast::Statement::SelectedVariableAssignment.new(owner, _expression, _target, _value, _choices)
  end
    
end
