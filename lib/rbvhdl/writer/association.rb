module RbVHDL::Ast
  
  class Association
    WRITE_DIRECTIVE = {:format => "%{formal}%{actual}"}

    def _write_string(directive={})
      format      = directive.fetch(:format, WRITE_DIRECTIVE[:format])
      formal_part = @_formal_part._write_string
      actual_part = @_actual_part._write_string
      return format % {actual: actual_part, formal: formal_part}
    end

    class FormalIndex
      WRITE_DIRECTIVE = {:format => ""}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {index: @_index.to_s}
      end
    end

    class FormalName
      WRITE_DIRECTIVE = {:format => "%{name} => "}
    
      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {name: @_name._write_string}
      end
    end

    class FormalFunction
      WRITE_DIRECTIVE = {:format => "%{name}(%{designator}) => "}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {name: @_name._write_string, designator: @_designator._write_string}
      end
    end
    
    class FormalTypeMark
      WRITE_DIRECTIVE = {:format => "%{type_mark}(%{designator}) => "}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {type_mark: @_type_mark._write_string, designator: @_designator._write_string}
      end
    end

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

    class ActualTypeMark < ActualPart
      WRITE_DIRECTIVE = {:format => "%{type_mark}(%{designator})"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {type_mark: @_type_mark._write_string, designator: @_designator._write_string}
      end
    end

    class ActualExpression < ActualPart
      WRITE_DIRECTIVE = {:format => "%{expression}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {expression: @_expression._write_string}
      end
    end

    class ActualOpen < ActualPart
      WRITE_DIRECTIVE = {:format => "%{keyword}", :keyword => "open"}

      def _write_string(directive={})
        format  = directive.fetch(:format , WRITE_DIRECTIVE[:format ])
        keyword = directive.fetch(:keyword, WRITE_DIRECTIVE[:keyword])
        return format % {keyword: keyword}
      end
    end
  end
end
