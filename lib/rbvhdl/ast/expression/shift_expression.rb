module RbVHDL::Ast
  #  
  # shift_expression    : simple_expression
  #                     | simple_expression "sll" simple_expression
  #                     | simple_expression "srl" simple_expression
  #                     | simple_expression "sla" simple_expression
  #                     | simple_expression "sra" simple_expression
  #                     | simple_expression "rol" simple_expression
  #                     | simple_expression "ror" simple_expression
  #
  class Expression
    class ShiftExpression < Relation
    end
  end
  
  def self.shift_expression(expr)
    if    expr.class < RbVHDL::Ast::Expression::ShiftExpression then
      return expr
    elsif expr.class < Numeric then
      return self.numeric_expression(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
