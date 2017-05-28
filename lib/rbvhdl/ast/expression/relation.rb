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
    if expr.class < RbVHDL::Ast::Expression::Relation then
      return expr
    else
      raise "abort #{self.class}.#{__method__}(#{expr}:#{expr.class}): Illegal class"
    end
  end

end
