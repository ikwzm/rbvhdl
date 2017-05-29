require_relative 'term'

module RbVHDL::Ast

  class Expression
    class Factor < Term
    end
  end

  def self.factor(expr)
    if    expr.class < RbVHDL::Ast::Expression::Factor then
      return expr
    elsif expr.class < Integer or expr.class == Float then
      return self.decimal_literal(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
