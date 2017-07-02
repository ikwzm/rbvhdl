require_relative 'primary'

module RbVHDL::Ast
  class Expression
    class ParenthesizedExpression < Primary
      attr_reader   :_expr
      def initialize(expr)
        super()
        @_expr = expr
      end
    end
  end

  def self.parenthesized_expression(expr)
    return RbVHDL::Ast::Expression::ParenthesizedExpression.new(RbVHDL::Ast.expression(expr))
  end

end
