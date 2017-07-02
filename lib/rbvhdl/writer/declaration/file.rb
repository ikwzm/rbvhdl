module RbVHDL::Ast

  module Declaration

    class File

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{keyword} %{identifier}:  %{type}%{value};",
        :keyword_format       => "%<keyword>-9s",
        :identifier_format    => "%{identifier}",
        :identifier_separator => ",",
        :identifier_align     => true,
        :type_format          => "%{type}",
        :value_format         => " %{file_open}%{_is_} %{string}",
        :file_open_format     => " %{_open_} %{expression}",
        :string_format        => "%{expression}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words    ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format ])
        type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format       ])
        value_format      = directive.fetch(:value_format     , WRITE_DIRECTIVE[:value_format      ])
        file_open_format  = directive.fetch(:file_open_format , WRITE_DIRECTIVE[:file_open_format  ])
        string_format     = directive.fetch(:string_format    , WRITE_DIRECTIVE[:string_format     ])

        keyword           = keyword_format    % {:keyword    => reserved_words[:file]              }
        identifier        = identifier_format % {:identifier => _write_identifier_string(directive)}
        type              = type_format       % {:type       => _write_type_string(directive)      }

        if @_string_expression.nil? then
          value = ""
        else
          if @_open_expression.nil? then
            file_open = ""
          else
            file_open = file_open_format % {
              :_open_     => reserved_words[:open],
              :expression => @_open_expression._write_string,
            }
          end
          value  = value_format % {
            :file_open   => file_open,
            :_is_        => reserved_words[:is],
            :string      => string_format % {:expression => @_string_expression._write_string},
          }
        end

        return [ format % {:indent => indent, :keyword => keyword, :identifier => identifier, :mode => mode, :type =>type, :value => value} ]
      end

      def _write_identifier_string(directive={})
        identifier_separator = directive.fetch(:identifier_separator , WRITE_DIRECTIVE[:identifier_separator])
        return @_identifier_list.map{|identifier| identifier._write_string}.join(identifier_separator)
      end

      def _write_type_string(directive={})
        return @_subtype_indication._write_string
      end
    end
      
  end
end

