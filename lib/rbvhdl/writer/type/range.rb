module RbVHDL::Ast

  module Type

    class RangeAttribute
      WRITE_DIRECTIVE = {:format => "%{name}"}

      def _write_string(directive={})
        format = directive.fetch(:format  , WRITE_DIRECTIVE[:format ])
        return format % {name: @_name._write_string}
      end
    end

    class RangeTo
      WRITE_DIRECTIVE = {:format => "%{left} %{keyword} %{right}", :keyword => "to"}

      def _write_string(directive={})
        format  = directive.fetch(:format  , WRITE_DIRECTIVE[:format ])
        keyword = directive.fetch(:keyword , WRITE_DIRECTIVE[:keyword])
        left    = @_l_expr._write_string
        right   = @_r_expr._write_string
        return format % {left: left, keyword: keyword, right: right}
      end
    end

    class RangeDownto
      WRITE_DIRECTIVE = {:format => "%{left} %{keyword} %{right}", :keyword => "downto"}

      def _write_string(directive={})
        format  = directive.fetch(:format  , WRITE_DIRECTIVE[:format ])
        keyword = directive.fetch(:keyword , WRITE_DIRECTIVE[:keyword])
        left    = @_l_expr._write_string
        right   = @_r_expr._write_string
        return format % {left: left, keyword: keyword, right: right}
      end
    end
  end
end
