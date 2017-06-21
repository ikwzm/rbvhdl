module RbVHDL::Ast
  
  class Association
    WRITE_DIRECTIVE = {
      :format        => "%{indent}%{formal}%{actual}%{separator}",
      :formal_format => "%{formal} => ",
      :actual_format => "%{actual}"    ,
    }

    def _write_string(directive={})
      indent        = directive.fetch(:indent   , "")
      separator     = directive.fetch(:separator, "")
      format        = directive.fetch(:format       , WRITE_DIRECTIVE[:format       ])
      formal_format = directive.fetch(:formal_format, WRITE_DIRECTIVE[:formal_format])
      actual_format = directive.fetch(:actual_format, WRITE_DIRECTIVE[:actual_format])
      formal_part   = _write_formal_part_string(directive)
      actual_part   = _write_actual_part_string(directive)
      if formal_part == "" then
        return format % {indent: indent, separator: separator, actual: actual_format % {actual: actual_part}, formal: formal_part                          }
      else
        return format % {indent: indent, separator: separator, actual: actual_format % {actual: actual_part}, formal: formal_format % {formal: formal_part}}
      end
    end

    def _write_line(directive={})
      return [ _write_string(directive) ]
    end

    def _write_formal_part_string(directive={})
      return @_formal_part._write_string(directive)
    end
    
    def _write_actual_part_string(directive={})
      return @_actual_part._write_string(directive)
    end
    
  end
end

require_relative 'association/formal_part'
require_relative 'association/actual_part'
