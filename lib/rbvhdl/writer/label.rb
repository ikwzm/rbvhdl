module RbVHDL::Ast

  class Label
    WRITE_DIRECTIVE = {:format => "%{label}"}

    def _write_string(directive={})
      format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
      return format % {label: self.to_s}
    end

  end
end

