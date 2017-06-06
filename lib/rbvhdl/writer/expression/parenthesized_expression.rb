module RbVHDL::Ast

  class Expression

    class ParenthesizedExpression
      RbVHDL::Writer._write_directive(self, {:format => "(%{expression})"})

      def _write_string(directive={})
        format = directive.fetch(:format , self.class._write_directive[:format])
        return format % {expression: @_expr._write_string}
      end
    end
  end
end
