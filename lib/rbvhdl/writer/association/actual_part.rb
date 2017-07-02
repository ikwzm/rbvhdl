require_relative '../reserved_words'

module RbVHDL::Ast

  class Association

    class ActualName
      WRITE_DIRECTIVE = {:format => "%{name}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {name: @_name._write_string}
      end
    end

    class ActualFunction
      WRITE_DIRECTIVE = {:format => "%{name}(%{designator})"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {name: @_name._write_string, designator: @_designator._write_string}
      end
    end

    class ActualTypeMark
      WRITE_DIRECTIVE = {:format => "%{type_mark}(%{designator})"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {type_mark: @_type_mark._write_string, designator: @_designator._write_string}
      end
    end

    class ActualExpression
      WRITE_DIRECTIVE = {:format => "%{expression}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {expression: @_expression._write_string}
      end
    end

    class ActualOpen
      WRITE_DIRECTIVE = {:format => "%{keyword}", :keywords => RbVHDL::Writer::RESERVED_WORDS}

      def _write_string(directive={})
        format   = directive.fetch(:format  , WRITE_DIRECTIVE[:format  ])
        keywords = directive.fetch(:keywords, WRITE_DIRECTIVE[:keywords])
        return format % {keyword: keywords[:open]}
      end
    end

  end
end
