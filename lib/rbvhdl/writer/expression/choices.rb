module RbVHDL::Ast

  class Expression

    class Choices
      WRITE_DIRECTIVE = {:format => "%{choices}", :choice_separator => " | "}

      def _write_string(directive={})
        format           = directive.fetch(:format          , WRITE_DIRECTIVE[:format           ])
        choice_separator = directive.fetch(:choice_separator, WRITE_DIRECTIVE[:choice_separator ])
        choices          = @_choice_list.map{ |choice| choice._write_string }.join(choice_separator)
        return format % {choices: choices}
      end
    end

    class ChoiceExpression
      WRITE_DIRECTIVE = {:format => "%{expression}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {expression: @_expression._write_string}
      end
    end

    class ChoiceRange
      WRITE_DIRECTIVE = {:format => "%{range}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {range: @_range._write_string}
      end
    end

    class ChoiceIdentifier
      WRITE_DIRECTIVE = {:format => "%{name}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {name: @_name._write_string}
      end
    end

    class ChoiceOthers
      WRITE_DIRECTIVE = {:keyword => "others", :format => "%{keyword}"}

      def _write_string(directive={})
        format  = directive.fetch(:format , WRITE_DIRECTIVE[:format ])
        keyword = directive.fetch(:keyword, WRITE_DIRECTIVE[:keyword])
        return format % {keyword: keyword}
      end
    end

  end
end
