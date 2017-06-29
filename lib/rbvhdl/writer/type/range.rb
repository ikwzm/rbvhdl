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
      WRITE_DIRECTIVE = {
        :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
        :format         => "%{left} %{keyword} %{right}",
      }

      def _write_string(directive={})
        reserved_words = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        format         = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        left           = @_l_expr._write_string
        right          = @_r_expr._write_string
        return format % {left: left, keyword: reserved_words[:to]    , right: right}
      end
    end

    class RangeDownto
      WRITE_DIRECTIVE = {
        :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
        :format         => "%{left} %{keyword} %{right}",
      }

      def _write_string(directive={})
        reserved_words = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        format         = directive.fetch(:format  , WRITE_DIRECTIVE[:format ])
        left           = @_l_expr._write_string
        right          = @_r_expr._write_string
        return format % {left: left, keyword: reserved_words[:downto], right: right}
      end
    end

  end
end
