module RbVHDL::Ast
  
  class Association
    WRITE_DIRECTIVE = {:format => "%{formal}%{actual}"}

    def _write_string(directive={})
      format      = directive.fetch(:format, WRITE_DIRECTIVE[:format])
      formal_part = @_formal_part._write_string
      actual_part = @_actual_part._write_string
      return format % {actual: actual_part, formal: formal_part}
    end
  end
end

require_relative 'association/formal_part'
require_relative 'association/actual_part'
