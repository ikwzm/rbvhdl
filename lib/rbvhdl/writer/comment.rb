module RbVHDL::Ast

  class Comment

    class Text
      WRITE_DIRECTIVE = {
        :format          => "%{indent}-- %{text}",
        :max_column      => 100,
      }
      def _write_line(directive={})
        indent          = directive.fetch(:indent    , "")
        format          = directive.fetch(:format         , WRITE_DIRECTIVE[:format         ])
        max_column      = directive.fetch(:max_column     , WRITE_DIRECTIVE[:max_column     ])
        if @_text.size == 0 then
          text_line = [""]
        else
          text_line = @_text.split(/\n/)
        end
        return text_line.map{|text| format % {:indent => indent, :text => text}}
      end
    end

    class HorizontalRule
      WRITE_DIRECTIVE = {
        :format          => "%{indent}--%{horizontal_rule}",
        :horizontal_char => "-",
        :max_column      => 100,
      }
      def _write_line(directive={})
        indent          = directive.fetch(:indent    , "")
        format          = directive.fetch(:format         , WRITE_DIRECTIVE[:format         ])
        max_column      = directive.fetch(:max_column     , WRITE_DIRECTIVE[:max_column     ])
        horizontal_char = directive.fetch(:horizontal_char, WRITE_DIRECTIVE[:horizontal_char])
        horizontal_rule = horizontal_char * (max_column - indent.size - 2)
        return [ format % {:indent => indent, :horizontal_rule => horizontal_rule} ]
      end
    end

    class NewLine
      WRITE_DIRECTIVE = {
      }
      def _write_line(directive={})
        return [""]
      end
    end
  end
end
