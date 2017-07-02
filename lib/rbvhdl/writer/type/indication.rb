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
        WRITE_DIRECTIVE = {
          :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
          :format         => " %{_range_} %{range}",
        }
        def _write_string(directive={})
          reserved_words = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
          format         = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
          return format % {_range_: reserved_words[:range], range: @_range._write_string}
        end
      end

      WRITE_DIRECTIVE = {:format => "%{type_mark}%{constraint}"}

      def _write_string(directive={})
        format     = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        type_mark  = @_type_mark._write_string
        constraint = (@_constraint.nil?)? "" : @_constraint._write_string
        return format % {type_mark: type_mark, constraint: constraint}
      end
    end

  end
end
