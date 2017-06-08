module RbVHDL::Ast

  class Expression

    class SimpleName
      WRITE_DIRECTIVE = {:format => "%{name}"}

      def _write_string(directive={})
        format = directive.fetch(:format , WRITE_DIRECTIVE[:format ])
        return format % {name: @_name._write_string}
      end
    end

    class FunctionCall
      WRITE_DIRECTIVE = {:format => "%{name}(%{parameter_list})", :parameter_separator => ", "}

      def _write_string(directive={})
        name = @_name._write_string
        if @_parameter_association_list.size == 0 then
          return name
        else
          format              = directive.fetch(:format             , WRITE_DIRECTIVE[:format             ])
          parameter_separator = directive.fetch(:parameter_separator, WRITE_DIRECTIVE[:parameter_separator])
          parameter_list      = @_parameter_association_list.map{ |param| param._write_string}.join(parameter_separator)
          return format % {name: name, parameter_list: parameter_list}
        end
      end
    end
    
    class IndexedName
      WRITE_DIRECTIVE = {:format => "%{name}(%{index_list})", :index_separator => ", "}

      def _write_string(directive={})
        name = @_prefix._write_string
        if @_index_list.size == 0 then
          return name
        else
          format          = directive.fetch(:format         , WRITE_DIRECTIVE[:format         ])
          index_separator = directive.fetch(:index_separator, WRITE_DIRECTIVE[:index_separator])
          index_list      = @_index_list.map{ |index| index._write_string}.join(index_separator)
          return format % {name: name, index_list: index_list}
        end
      end
    end
  
    class SliceName
      WRITE_DIRECTIVE = {:format => "%{name}(%{range})"}

      def _write_string(directive={})
        name = @_prefix._write_string
        if @_range.nil? then
          return name
        else
          format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
          range  = @_range._write_string
          return format % {name: name, range: range}
        end
      end
    end
  
    class SelectedName
      WRITE_DIRECTIVE = {:format => "%{prefix}.%{suffix}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {prefix: @_prefix._write_string, suffix: @_suffix._write_string}
      end
    end

    class All
      WRITE_DIRECTIVE = {:keyword => "all", :format => "%{keyword}"}
      
      def _write_string(directive={})
        format  = directive.fetch(:format , WRITE_DIRECTIVE[:format ])
        keyword = directive.fetch(:keyword, WRITE_DIRECTIVE[:keyword])
        return format % {keyword: keyword}
      end
    end

    class AttributeName
      WRITE_DIRECTIVE = {:format => "%{name}'%{attribute}"}

      def _write_string(directive={})
        name      = @_name._write_string
        format    = directive.fetch(:format , WRITE_DIRECTIVE[:format ])
        attribute = @_attribute._write_string
        unless @_expression.nil? then
          expression = @_expression._write_string
          attribute  = "%{attribute}(%{expression})" % {attribute: attribute, expression: expression}
        end
        return format % {name: name, attribute: attribute}
      end
    end

  end
end
