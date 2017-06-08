module RbVHDL::Ast

  class Expression

    class ParenthesizedExpression
      WRITE_DIRECTIVE = {:format => "(%{expression})"}

      def _write_string(directive={})
        format = directive.fetch(:format , WRITE_DIRECTIVE[:format])
        return format % {expression: @_expr._write_string}
      end
    end
  end
end
