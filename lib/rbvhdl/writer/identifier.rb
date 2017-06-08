module RbVHDL::Ast

  class Identifier
    WRITE_DIRECTIVE = {:format => "%{identifier}"}

    def _write_string(directive={})
      format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
      return format % {identifier: self.to_s}
    end
  end
end

