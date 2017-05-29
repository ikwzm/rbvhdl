require_relative 'relation'

module RbVHDL::Ast

  class Expression
    class ShiftExpression < Relation
    end
  end
  
  def self.shift_expression(expr)
    if    expr.class < RbVHDL::Ast::Expression::ShiftExpression then
      return expr
    elsif expr.class < Integer or expr.class == Floast then
      return self.decimal_literal(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
