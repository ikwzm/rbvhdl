require_relative 'shift_expression'

module RbVHDL::Ast

  class Expression
    class SimpleExpression < ShiftExpression
    end
  end

  def self.simple_expression(expr)
    if expr.class < RbVHDL::Ast::Expression::SimpleExpression then
      return expr
    else
      raise "abort #{self.class}.#{__method__}(#{expr}:#{expr.class}): Illegal class"
    end
  end

end

