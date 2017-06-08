module RbVHDL::Ast
  module Type
    class Mark
      WRITE_DIRECTIVE = {:format => "%{type_mark}"}
      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {type_mark: self.to_s}
      end
    end
  end
end

