module RbVHDL::Ast
  # logical_expression  : relation
  #                     | relation "and"  relation
  #                     | relation "nand" relation
  #                     | relation "or"   relation
  #                     | relation "nor"  relation
  #                     | relation "xor"  relation
  #                     | relation "xnor" relation
  class Expression
    class LogicalExpression < Expression
    end
  end

  def self.logical_expression(expr)
    if expr.class < RbVHDL::Ast::Expression::LogicalExpression then
      return expr
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
