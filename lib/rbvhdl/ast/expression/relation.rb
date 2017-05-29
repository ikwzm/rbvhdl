require_relative 'logical_expression'

module RbVHDL::Ast
  # relation            : shift_expression
  #                     | shift_expression "="  shift_expression
  #                     | shift_expression "/=" shift_expression
  #                     | shift_expression "<"  shift_expression
  #                     | shift_expression "<=" shift_expression
  #                     | shift_expression ">"  shift_expression
  #                     | shift_expression ">=" shift_expression
  class Expression
    class Relation < LogicalExpression
    end
  end

  def self.relation(expr)
    if    expr.class < RbVHDL::Ast::Expression::Relation then
      return expr
    elsif expr.class < Integer or expr.class == Float then
      return self.decimal_literal(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
