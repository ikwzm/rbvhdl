module RbVHDL::Ast

  module Type

    class IntegerDefinition
      WRITE_DIRECTIVE = {:keyword => "range", :format => "%{keyword} %{range}"}
      def _write_string(directive={})
        keyword = directive.fetch(:range_keyword, WRITE_DIRECTIVE[:keyword])
        format  = directive.fetch(:format       , WRITE_DIRECTIVE[:format ])
        return format % {keyword: keyword, range: @_range._write_string}
      end
    end

    class FloatingDefinition
      WRITE_DIRECTIVE = {:keyword => "range", :format => "%{keyword} %{range}"}
      def _write_string(directive={})
        keyword = directive.fetch(:range_keyword, WRITE_DIRECTIVE[:keyword])
        format  = directive.fetch(:format       , WRITE_DIRECTIVE[:format ])
        return format % {keyword: keyword, range: @_range._write_string}
      end
    end

    class PhysicalDefinition
      WRITE_DIRECTIVE = {:keyword           => "units",
                         :range_keyword     => "range",
                         :end_keyword       => "end",
                         :begin_format      => "%{range} %{keyword}",
                         :end_format        => "%{indent}%{end_keyword} %{keyword}",
                         :range_format      => "%{range_keyword} %{range}",
                         :primary_indent    => "    ",
                         :primary_format    => "%{indent}%{primary_indent}%{unit};",
                         :secondary_indent  => "    ",
                         :secondary_format  => "%{indent}%{secondary_indent}%{unit} = %{literal};",
                         :unit_format       => "%{unit}",
                         :literal_format    => "%{literal}", 
      }
      def _write_string(directive={})
        indent           = directive.fetch(:indent    , "")
        identifier       = directive.fetch(:identifier, "")
        units_keyword    = directive.fetch(:units_keyword    , WRITE_DIRECTIVE[:keyword          ])
        range_keyword    = directive.fetch(:range_keyword    , WRITE_DIRECTIVE[:range_keyword    ])
        end_keyword      = directive.fetch(:end_keyword      , WRITE_DIRECTIVE[:end_keyword      ])
        begin_format     = directive.fetch(:begin_format     , WRITE_DIRECTIVE[:begin_format     ])
        end_format       = directive.fetch(:end_format       , WRITE_DIRECTIVE[:end_format       ])
        range_format     = directive.fetch(:range_format     , WRITE_DIRECTIVE[:range_format     ])
        primary_indent   = directive.fetch(:primary_indent   , WRITE_DIRECTIVE[:primary_indent   ])
        primary_format   = directive.fetch(:primary_format   , WRITE_DIRECTIVE[:primary_format   ])
        secondary_indent = directive.fetch(:secondary_indent , WRITE_DIRECTIVE[:secondary_indent ])
        secondary_format = directive.fetch(:secondary_format , WRITE_DIRECTIVE[:secondary_format ])
        unit_format      = directive.fetch(:unit_format      , WRITE_DIRECTIVE[:unit_format      ])
        literal_format   = directive.fetch(:literal_format   , WRITE_DIRECTIVE[:literal_format   ])

        range            =    range_format % {range_keyword: range_keyword, range: @_range._write_string}
        primary_unit     =     unit_format % {unit: @_unit._write_string}

        write_line       = [  begin_format % {indent: indent, keyword: units_keyword, range: range} ]
        write_line.push(    primary_format % {indent: indent, primary_indent: primary_indent, unit: primary_unit})
        @_unit_list.each do |unit_pair|
          secondary_unit =  unit_format    % {unit:    unit_pair[0]._write_string}
          literal        =  literal_format % {literal: unit_pair[1]._write_string}
          write_line.push(secondary_format % {indent: indent, secondary_indent: secondary_indent, unit: secondary_unit, literal: literal})
        end
        write_line.push(        end_format % {indent: indent, keyword: units_keyword, end_keyword: end_keyword, identifier: identifier})
        return write_line.join("\n")
      end
    end

    class ArrayDefinition
      WRITE_DIRECTIVE = {:keyword           => "array",
                         :range_keyword     => "range",
                         :of_keyword        => "of"   ,
                         :format            => "%{keyword} (%{range_list}) %{of_keyword} %{subtype_indication}",
      }
      def _write_string(directive={})
        array_keyword      = directive.fetch(:array_keyword, WRITE_DIRECTIVE[:keyword      ])
        range_keyword      = directive.fetch(:range_keyword, WRITE_DIRECTIVE[:range_keyword])
        of_keyword         = directive.fetch(:of_keyword   , WRITE_DIRECTIVE[:of_keyword   ])
        format             = directive.fetch(:format       , WRITE_DIRECTIVE[:format       ])
        range_list         = @_range_list.map { |range|
          if range.class < RbVHDL::Ast::Expression::Name then
            "#{range._write_string} #{range_keyword} <>"
          else
            "#{range._write_string}"
          end
        }.join(", ")
        subtype_indication = @_subtype_indication._write_string
        return format % {keyword: array_keyword, range_list: range_list, of_keyword: of_keyword, subtype_indication: subtype_indication}
      end
    end

    class EnumerationDefinition
      WRITE_DIRECTIVE = {:format => "(%{enum_list})", :enum_separator => ", "}
      def _write_string(directive={})
        enum_separator = directive.fetch(:enum_separator, WRITE_DIRECTIVE[:enum_separator])
        format         = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        enum_list      = @_enum_list.map{|enum| enum._write_string}.join(enum_separator)
        return format % {enum_list: enum_list}
      end
    end

    class RecordDefinition
      WRITE_DIRECTIVE = {:keyword           => "record",
                         :end_keyword       => "end",
                         :begin_format      => "%{keyword}",
                         :end_format        => "%{indent}%{end_keyword} %{keyword}",
                         :field_indent      => "    ",
                         :field_format      => "%{indent}%{field_indent}%{identifier} :  %{type};",
                         :identifier_format => "%{identifier}",
                         :type_format       => "%{type}", 
      }
      def _write_string(directive={})
        indent            = directive.fetch(:indent, "")
        field_indent      = directive.fetch(:field_indent     , WRITE_DIRECTIVE[:field_indent     ])
        keyword           = directive.fetch(:record_keyword   , WRITE_DIRECTIVE[:keyword          ])
        end_keyword       = directive.fetch(:end_keyword      , WRITE_DIRECTIVE[:end_keyword      ])
        begin_format      = directive.fetch(:begin_format     , WRITE_DIRECTIVE[:begin_format     ])
        end_format        = directive.fetch(:end_format       , WRITE_DIRECTIVE[:end_format       ])
        field_format      = directive.fetch(:field_format     , WRITE_DIRECTIVE[:field_format     ])
        identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format])
        type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format      ])
  
        write_line   = [ begin_format  % {indent: indent, keyword: keyword} ]
        @_field_list.each do |field|
          identifier = identifier_format % {identifier: field._identifier        ._write_string}
          type       = type_format       % {type:       field._subtype_indication._write_string}
          write_line.push(field_format % {indent: indent, field_indent: field_indent, identifier: identifier, type: type} )
        end
        write_line.push(   end_format  % {indent: indent, keyword: keyword, end_keyword: end_keyword})
        return write_line.join("\n")
      end
    end

    class FileDefinition
      WRITE_DIRECTIVE = {:keyword => "file", :of_keyword => "of", :format => "%{keyword} %{of_keyword} %{type_mark}"}
      def _write_string(directive={})
        file_keyword = directive.fetch(:file_keyword, WRITE_DIRECTIVE[:keyword   ])
        of_keyword   = directive.fetch(:of_keyword  , WRITE_DIRECTIVE[:of_keyword])
        format       = directive.fetch(:format      , WRITE_DIRECTIVE[:format    ])
        return format % {keyword: file_keyword, of_keyword: of_keyword, type_mark: @_type_mark._write_string}
      end
    end

    class AccessDefinition
      WRITE_DIRECTIVE = {:keyword => "access", :format => "%{keyword} %{subtype_indication}"}
      def _write_string(directive={})
        keyword = directive.fetch(:access_keyword, WRITE_DIRECTIVE[:keyword])
        format  = directive.fetch(:format        , WRITE_DIRECTIVE[:format ])
        return format % {keyword: keyword, subtype_indication: @_subtype_indication._write_string}
      end
    end

  end
end
