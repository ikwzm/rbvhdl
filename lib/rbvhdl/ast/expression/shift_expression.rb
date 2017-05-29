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
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
