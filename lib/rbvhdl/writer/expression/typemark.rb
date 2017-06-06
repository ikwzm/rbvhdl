module RbVHDL::Ast

  class Expression

    class TypeMark
      RbVHDL::Writer._write_directive(self, {:format => "%{type_mark}(%{expression})"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {type_mark: @_name._write_string, expression: @_expr._write_string}
      end
    end
  end
end

