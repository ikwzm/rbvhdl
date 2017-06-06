module RbVHDL::Ast

  class Expression

    class Choices
      RbVHDL::Writer._write_directive(self, {:format => "%{choices}", :choice_separator => " | "})

      def _write_string(directive={})
        format           = directive.fetch(:format          , self.class._write_directive[:format           ])
        choice_separator = directive.fetch(:choice_separator, self.class._write_directive[:choice_separator ])
        choices          = @_choice_list.map{ |choice| choice._write_string }.join(choice_separator)
        return format % {choices: choices}
      end
    end

    class ChoiceExpression
      RbVHDL::Writer._write_directive(self, {:format => "%{expression}"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {expression: @_expression._write_string}
      end
    end

    class ChoiceRange
      RbVHDL::Writer._write_directive(self, {:format => "%{range}"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {range: @_range._write_string}
      end
    end

    class ChoiceIdentifier
      RbVHDL::Writer._write_directive(self, {:format => "%{name}"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {name: @_name._write_string}
      end
    end

    class ChoiceOthers
      RbVHDL::Writer._write_directive(self, {:keyword => "others", :format => "%{keyword}"})

      def _write_string(directive={})
        format  = directive.fetch(:format , self.class._write_directive[:format ])
        keyword = directive.fetch(:keyword, self.class._write_directive[:keyword])
        return format % {keyword: keyword}
      end
    end
  end
end
