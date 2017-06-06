module RbVHDL::Ast

  class Label
    RbVHDL::Writer._write_directive(self, {:format => "%{label}"})

    def _write_string(directive={})
      format = directive.fetch(:format, self.class._write_directive[:format])
      return format % {label: self.to_s}
    end

  end
end

