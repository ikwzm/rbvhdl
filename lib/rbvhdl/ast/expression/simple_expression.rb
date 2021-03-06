module RbVHDL::Ast
  #
  # simple_expression   :  ["+"|"-"]  term {( "+" | "-" | "&") term}
  #
  class Expression
    class SimpleExpression < ShiftExpression
    end
  end

  def self.simple_expression(expr)
    if    expr.class < RbVHDL::Ast::Expression::SimpleExpression then
      return expr
    elsif expr.class < Numeric then
      return self.numeric_expression(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end

