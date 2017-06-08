module RbVHDL::Ast

  class Expression

    class TypeMark
      WRITE_DIRECTIVE = {:format => "%{type_mark}(%{expression})"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {type_mark: @_name._write_string, expression: @_expr._write_string}
      end
    end
  end
end

