module RbVHDL::Ast
  #
  # term                :  factor {("*" | "/" | "mod" | "rem") factor}
  #
  class Expression
    class Term < SimpleExpression
    end
  end

  def self.term(expr)
    if    expr.class < RbVHDL::Ast::Expression::Term then
      return expr
    elsif expr.class < Numeric then
      return self.numeric_expression(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
