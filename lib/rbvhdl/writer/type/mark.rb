module RbVHDL::Ast
  module Type
    class Mark
      RbVHDL::Writer._write_directive(self, {:format => "%{type_mark}"})
      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {type_mark: self.to_s}
      end
    end
  end
end

