module RbVHDL::Ast

  class Expression

    class SimpleName
      RbVHDL::Writer._write_directive(self, {:format => "%{name}"})

      def _write_string(directive={})
        format = directive.fetch(:format , self.class._write_directive[:format ])
        return format % {name: @_name._write_string}
      end
    end

    class FunctionCall
      RbVHDL::Writer._write_directive(self, {:format => "%{name}(%{parameter_list})", :parameter_separator => ", "})

      def _write_string(directive={})
        name = @_name._write_string
        if @_parameter_association_list.size == 0 then
          return name
        else
          format              = directive.fetch(:format             , self.class._write_directive[:format             ])
          parameter_separator = directive.fetch(:parameter_separator, self.class._write_directive[:parameter_separator])
          parameter_list      = @_parameter_association_list.map{ |param| param._write_string}.join(parameter_separator)
          return format % {name: name, parameter_list: parameter_list}
        end
      end
    end
    
    class IndexedName
      RbVHDL::Writer._write_directive(self, {:format => "%{name}(%{index_list})", :index_separator => ", "})

      def _write_string(directive={})
        name = @_prefix._write_string
        if @_index_list.size == 0 then
          return name
        else
          format          = directive.fetch(:format         , self.class._write_directive[:format         ])
          index_separator = directive.fetch(:index_separator, self.class._write_directive[:index_separator])
          index_list      = @_index_list.map{ |index| index._write_string}.join(index_separator)
          return format % {name: name, index_list: index_list}
        end
      end
    end
  
    class SliceName
      RbVHDL::Writer._write_directive(self, {:format => "%{name}(%{range})"})

      def _write_string(directive={})
        name = @_prefix._write_string
        if @_range.nil? then
          return name
        else
          format = directive.fetch(:format, self.class._write_directive[:format])
          range  = @_range._write_string
          return format % {name: name, range: range}
        end
      end
    end
  
    class SelectedName
      RbVHDL::Writer._write_directive(self, {:format => "%{prefix}.%{suffix}"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {prefix: @_prefix._write_string, suffix: @_suffix._write_string}
      end
    end

    class All
      RbVHDL::Writer._write_directive(self, {:keyword => "all", :format => "%{keyword}"})
      
      def _write_string(directive={})
        format  = directive.fetch(:format , self.class._write_directive[:format ])
        keyword = directive.fetch(:keyword, self.class._write_directive[:keyword])
        return format % {keyword: keyword}
      end
    end

    class AttributeName
      RbVHDL::Writer._write_directive(self, {:format => "%{name}'%{attribute}"})

      def _write_string(directive={})
        name      = @_name._write_string
        format    = directive.fetch(:format , self.class._write_directive[:format ])
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
