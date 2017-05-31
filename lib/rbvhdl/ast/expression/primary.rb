require_relative 'factor'

module RbVHDL::Ast

  class Expression
    # primary             :  name
    #                     |  literal
    #                     |  aggregate
    #                     |  function_call
    #                     |  qualified_expression
    #                     |  type_mark "(" expression ")"
    #                     |  new subtype_indication
    #                     |  new qualified_expression
    #                     |  "(" expression ")"
    class Primary < Factor
    end
  end

  def self.primary(expr)
    if expr.class < RbVHDL::Ast::Expression::Primary then
      return expr
    elsif expr.class < Integer or expr.class == Float then
      return self.decimal_literal(expr)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{expr.inspect}:#{expr.class})"
    end
  end

end
