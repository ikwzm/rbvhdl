module RbVHDL::Ast

  class Expression

    class Aggregate
      class Item
        RbVHDL::Writer._write_directive(self, {:format => "%{choices}%{expression}", :choices_format => "%{choices} => "})
        
        def _write_string(directive={})
          format     = directive.fetch(:format, self.class._write_directive[:format])
          expression = @_expression._write_string
          if @_choices.nil? then
            return format % {expression: expression, choices: ""}
          else
            choices_format = directive.fetch(:choices_format, self.class._write_directive[:choices_format])
            choices        = choices_format % {choices: @_choices._write_string}
            return format % {expression: expression, choices: choices}
          end            
        end
      end

      RbVHDL::Writer._write_directive(self, {:format => "(%{item_list})", :item_separator => ", "})
        
      def _write_string(directive={})
        format         = directive.fetch(:format        , self.class._write_directive[:format        ])
        item_separator = directive.fetch(:item_separator, self.class._write_directive[:item_separator])
        item_list      = @_item_list.map{ |item| item._write_string }.join(item_separator)
        return format % {item_list: item_list}
      end
    end

  end
end
