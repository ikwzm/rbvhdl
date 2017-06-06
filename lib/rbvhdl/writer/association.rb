module RbVHDL::Ast
  
  class Association
    RbVHDL::Writer._write_directive(self, {:format => "%{formal}%{actual}"})

    def _write_string(directive={})
      format      = directive.fetch(:format, self.class._write_directive[:format])
      formal_part = @_formal_part._write_string
      actual_part = @_actual_part._write_string
      return format % {actual: actual_part, formal: formal_part}
    end

    class FormalIndex
      RbVHDL::Writer._write_directive(self, {:format => ""})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {index: @_index.to_s}
      end
    end

    class FormalName
      RbVHDL::Writer._write_directive(self, {:format => "%{name} => "})
    
      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {name: @_name._write_string}
      end
    end

    class FormalFunction
      RbVHDL::Writer._write_directive(self, {:format => "%{name}(%{designator}) => "})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {name: @_name._write_string, designator: @_designator._write_string}
      end
    end
    
    class FormalTypeMark
      RbVHDL::Writer._write_directive(self, {:format => "%{type_mark}(%{designator}) => "})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {type_mark: @_type_mark._write_string, designator: @_designator._write_string}
      end
    end

    class ActualName
      RbVHDL::Writer._write_directive(self, {:format => "%{name}"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {name: @_name._write_string}
      end
    end

    class ActualFunction
      RbVHDL::Writer._write_directive(self, {:format => "%{name}(%{designator})"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {name: @_name._write_string, designator: @_designator._write_string}
      end
    end

    class ActualTypeMark < ActualPart
      RbVHDL::Writer._write_directive(self, {:format => "%{type_mark}(%{designator})"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {type_mark: @_type_mark._write_string, designator: @_designator._write_string}
      end
    end

    class ActualExpression < ActualPart
      RbVHDL::Writer._write_directive(self, {:format => "%{expression}"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {expression: @_expression._write_string}
      end
    end

    class ActualOpen < ActualPart
      RbVHDL::Writer._write_directive(self, {:format => "%{keyword}", :keyword => "open"})

      def _write_string(directive={})
        format  = directive.fetch(:format , self.class._write_directive[:format ])
        keyword = directive.fetch(:keyword, self.class._write_directive[:keyword])
        return format % {keyword: keyword}
      end
    end
  end
end
