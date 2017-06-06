module RbVHDL::Ast
  #
  # factor              :  primary
  #                     |  primary "**" primary
  #                     |  "abs"  primary
  #                     |  "not"  primary
  #                     |  "and"  primary
  #                     |  "nand" primary
  #                     |  "or"   primary
  #                     |  "nor"  primary
  #                     |  "xor"  primary
  #                     |  "xnor" primary
  #
  class Expression
    class Factor < Term
    end
  end

  def self.factor(expr)
    if    expr.class < RbVHDL::Ast::Expression::Factor then
      return expr
    elsif expr.class < Numeric then
      return self.numeric_expression(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
