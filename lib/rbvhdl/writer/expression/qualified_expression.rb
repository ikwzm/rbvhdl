module RbVHDL::Ast

  class Expression

    class QualifiedExpression
      WRITE_DIRECTIVE = {:format => "%{type_mark}'%{argument}"}

      def _write_string(directive={})
        format    = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        type_mark = @_type_mark._write_string
        if @_argument.class == RbVHDL::Ast::Expression::Aggregate then
          argument = @_argument._write_string
        else
          argument = "(" + @_argument._write_string + ")"
        end
        return format % {type_mark: type_mark, argument: argument}
      end
    end

    class NewQualifiedExpression
      WRITE_DIRECTIVE = {:format => "new %{type_mark}'%{argument}"}

      def _write_string(directive={})
        format    = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        type_mark = @_type_mark._write_string
        if @_argument.class == RbVHDL::Ast::Expression::Aggregate then
          argument = @_argument._write_string
        else
          argument = "(" + @_argument._write_string + ")"
        end
        return format % {type_mark: type_mark, argument: argument}
      end
    end

  end
end

    
