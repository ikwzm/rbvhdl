require_relative 'term'

module RbVHDL::Ast

  class Expression
    class Factor < Term
    end
  end

  def self.factor(expr)
    if expr.class < RbVHDL::Ast::Expression::Factor then
      return expr
    else
      raise "abort #{self.class}.#{__method__}(#{expr}:#{expr.class}): Illegal class"
    end
  end

end
