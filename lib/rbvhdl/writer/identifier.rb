module RbVHDL::Ast

  class Identifier
    RbVHDL::Writer._write_directive(self, {:format => "%{identifier}"})

    def _write_string(directive={})
      format = directive.fetch(:format, self.class._write_directive[:format])
      return format % {identifier: self.to_s}
    end
  end
end

