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
    else
      raise "abort #{self.class}.#{__method__}(#{expr}:#{expr.class}): Illegal class"
    end
  end

end
