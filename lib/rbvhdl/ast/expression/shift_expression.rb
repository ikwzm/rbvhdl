require_relative 'relation'

module RbVHDL::Ast

  class Expression
    class ShiftExpression < Relation
    end
  end
  
  def self.shift_expression(expr)
    if expr.class < RbVHDL::Ast::Expression::ShiftExpression then
      return expr
    else
      raise "abort #{self.class}.#{__method__}(#{expr}:#{expr.class}): Illegal class"
    end
  end

end
