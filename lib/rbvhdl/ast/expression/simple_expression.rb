require_relative 'shift_expression'

module RbVHDL::Ast

  class Expression
    class SimpleExpression < ShiftExpression
    end
  end

  def self.simple_expression(expr)
    if    expr.class < RbVHDL::Ast::Expression::SimpleExpression then
      return expr
    elsif expr.class < Integer or expr.class == Float then
      return self.decimal_literal(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end

