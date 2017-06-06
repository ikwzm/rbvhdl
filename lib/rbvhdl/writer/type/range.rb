module RbVHDL::Ast

  module Type

    class RangeAttribute
      RbVHDL::Writer._write_directive(self, {:format => "%{name}"})

      def _write_string(directive={})
        format = directive.fetch(:format  , self.class._write_directive[:format ])
        return format % {name: @_name._write_string}
      end
    end

    class RangeTo
      RbVHDL::Writer._write_directive(self, {:format => "%{left} %{keyword} %{right}", :keyword => "to"})

      def _write_string(directive={})
        format  = directive.fetch(:format  , self.class._write_directive[:format ])
        keyword = directive.fetch(:keyword , self.class._write_directive[:keyword])
        left    = @_l_expr._write_string
        right   = @_r_expr._write_string
        return format % {left: left, keyword: keyword, right: right}
      end
    end

    class RangeDownto
      RbVHDL::Writer._write_directive(self, {:format => "%{left} %{keyword} %{right}", :keyword => "downto"})

      def _write_string(directive={})
        format  = directive.fetch(:format  , self.class._write_directive[:format ])
        keyword = directive.fetch(:keyword , self.class._write_directive[:keyword])
        left    = @_l_expr._write_string
        right   = @_r_expr._write_string
        return format % {left: left, keyword: keyword, right: right}
      end
    end
  end
end
