module RbVHDL::Ast
  module Type

    class Indication

      class ArrayConstraint
        def _write_string(directive={})
          return "(" + @_range_list.map{|range| range._write_string}.join(",") + ")"
        end
      end

      class RecordConstraint
      end

      class RangeConstraint
        RbVHDL::Writer._write_directive(self, {:keyword => "range", :format => " %{keyword} %{range}"})
        def _write_string(directive={})
          keyword = directive.fetch(:keyword, self.class._write_directive[:keyword])
          format  = directive.fetch(:format , self.class._write_directive[:format ])
          return format % {keyword: keyword, range: @_range._write_string}
        end
      end

      RbVHDL::Writer._write_directive(self, {:format => "%{type_mark}%{constraint}"})

      def _write_string(directive={})
        format     = directive.fetch(:format, self.class._write_directive[:format])
        type_mark  = @_type_mark._write_string
        constraint = (@_constraint.nil?)? "" : @_constraint._write_string
        return format % {type_mark: type_mark, constraint: constraint}
      end

    end

  end
end
