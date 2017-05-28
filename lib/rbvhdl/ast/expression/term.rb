require_relative 'simple_expression'

module RbVHDL::Ast

  class Expression
    class Term < SimpleExpression
    end
  end

  def self.unary_term(expr)
    if expr.class == RbVHDL::Ast::Expression::UnaryPlus  or
       expr.class == RbVHDL::Ast::Expression::UnaryMinus or
       expr.class  < RbVHDL::Ast::Expression::Term       then
      return expr
    else
      raise "abort #{self.class}.#{__method__}(#{expr}:#{expr.class}): Illegal class"
    end
  end

  def self.term(expr)
    if expr.class < RbVHDL::Ast::Expression::Term then
      return expr
    else
      raise "abort #{self.class}.#{__method__}(#{expr}:#{expr.class}): Illegal class"
    end
  end

end
