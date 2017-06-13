module RbVHDL::Ast

  class Association

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

  end
end

