require_relative 'primary'

module RbVHDL::Ast
  class Expression
    class ParenthesizedExpression < Primary
      attr_reader   :_expr
      def initalize(expr)
        super()
        @_expr =_expr
      end
    end
  end

  def self.parenthesized_expression(expr)
    return RbVHDL::Ast::Expression::ParenthesizedExpression(RbVHDL::Ast.expression(expr))
  end

end
