module RbVHDL::Ast

  module Type

    class IntegerDefinition
      WRITE_DIRECTIVE = {
        :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
        :format         => "%{_range_} %{range}",
      }
      def _write_string(directive={})
        reserved_words = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        format         = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        return format % {_range_: reserved_words[:range], range: @_range._write_string}
      end
    end

    class FloatingDefinition
      WRITE_DIRECTIVE = {
        :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
        :format         => "%{_range_} %{range}",
      }
      def _write_string(directive={})
        reserved_words = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        format         = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        return format % {_range_: reserved_words[:range], range: @_range._write_string}
      end
    end

    class PhysicalDefinition
      WRITE_DIRECTIVE = {
        :reserved_words    => RbVHDL::Writer::RESERVED_WORDS,
        :begin_format      => "%{range} %{_units_}",
        :end_format        => "%{indent}%{_end_} %{_units_}",
        :range_format      => "%{_range_} %{range}",
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
        begin_format     = directive.fetch(:begin_format     , WRITE_DIRECTIVE[:begin_format     ])
        end_format       = directive.fetch(:end_format       , WRITE_DIRECTIVE[:end_format       ])
        range_format     = directive.fetch(:range_format     , WRITE_DIRECTIVE[:range_format     ])
        primary_indent   = directive.fetch(:primary_indent   , WRITE_DIRECTIVE[:primary_indent   ])
        primary_format   = directive.fetch(:primary_format   , WRITE_DIRECTIVE[:primary_format   ])
        secondary_indent = directive.fetch(:secondary_indent , WRITE_DIRECTIVE[:secondary_indent ])
        secondary_format = directive.fetch(:secondary_format , WRITE_DIRECTIVE[:secondary_format ])
        unit_format      = directive.fetch(:unit_format      , WRITE_DIRECTIVE[:unit_format      ])
        literal_format   = directive.fetch(:literal_format   , WRITE_DIRECTIVE[:literal_format   ])
        reserved_words   = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        write_line       = [  begin_format % {
          :indent         => indent,
          :_units_        => reserved_words[:units],
          :range          => range_format % {:_range_ => reserved_words[:range], :range => @_range._write_string}
        }]
        write_line.push   primary_format % {
          :indent         => indent,
          :primary_indent => primary_indent,
          :unit           => unit_format  % {:unit    => @_unit._write_string}
        }
        @_unit_list.each do |unit_pair|
          write_line.push secondary_format % {
            :indent           => indent,
            :secondary_indent => secondary_indent,
            :unit             => unit_format    % {:unit   => unit_pair[0]._write_string},
            :literal          => literal_format % {:literal=> unit_pair[1]._write_string},
          }
        end
        write_line.push   end_format % {
          :indent         => indent,
          :_units_        => reserved_words[:units],
          :_end_          => reserved_words[:end],
          :identifier     => identifier
        }
        return write_line.join("\n")
      end
    end

    class ArrayDefinition
      WRITE_DIRECTIVE = {
        :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
        :format         => "%{_array_} (%{range_list}) %{_of_} %{subtype_indication}",
      }
      def _write_string(directive={})
        reserved_words   = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        format           = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        range_list       = @_range_list.map { |range|
          if range.class < RbVHDL::Ast::Expression::Name then
            "#{range._write_string} #{reserved_words[:range]} <>"
          else
            "#{range._write_string}"
          end
        }.join(", ")
        subtype_indication = @_subtype_indication._write_string
        return format % {
          :_array_            => reserved_words[:array],
          :range_list         => range_list,
          :_of_               => reserved_words[:of],
          :subtype_indication => subtype_indication
        }
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
      WRITE_DIRECTIVE = {
        :reserved_words    => RbVHDL::Writer::RESERVED_WORDS,
        :begin_format      => "%{_record_}",
        :end_format        => "%{indent}%{_end_} %{_record_}",
        :field_indent      => "    ",
        :field_format      => "%{indent}%{field_indent}%{identifier} :  %{type};",
        :identifier_format => "%{identifier}",
        :type_format       => "%{type}", 
      }
      def _write_string(directive={})
        indent            = directive.fetch(:indent, "")
        field_indent      = directive.fetch(:field_indent     , WRITE_DIRECTIVE[:field_indent     ])
        begin_format      = directive.fetch(:begin_format     , WRITE_DIRECTIVE[:begin_format     ])
        end_format        = directive.fetch(:end_format       , WRITE_DIRECTIVE[:end_format       ])
        field_format      = directive.fetch(:field_format     , WRITE_DIRECTIVE[:field_format     ])
        identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format])
        type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format      ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])
  
        write_line   = [ begin_format  % {
          :indent   => indent,
          :_record_ => reserved_words[:record]
        } ]
        @_field_list.each do |field|
          write_line.push field_format % {
            :indent       => indent,
            :field_indent => field_indent,
            :identifier   => identifier_format % {:identifier => field._identifier        ._write_string},
            :type         => type_format       % {:type       => field._subtype_indication._write_string},
          }
        end
        write_line.push end_format  % {
          :indent   => indent,
          :_end_    => reserved_words[:end],
          :_record_ => reserved_words[:record],
        }
        return write_line.join("\n")
      end
    end

    class FileDefinition
      WRITE_DIRECTIVE = {
        :reserved_words    => RbVHDL::Writer::RESERVED_WORDS,
        :format            => "%{_file_} %{_of_} %{type_mark}",
      }
      def _write_string(directive={})
        format         = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        reserved_words = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        return format % {:_file_ => reserved_words[:file], :_of_ => reserved_words[:of], :type_mark => @_type_mark._write_string}
      end
    end

    class AccessDefinition
      WRITE_DIRECTIVE = {
        :reserved_words    => RbVHDL::Writer::RESERVED_WORDS,
        :format            => "%{_access_} %{subtype_indication}"
      }
      def _write_string(directive={})
        format         = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        reserved_words = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        return format % {_access_: reserved_words[:access], subtype_indication: @_subtype_indication._write_string}
      end
    end

  end
end
