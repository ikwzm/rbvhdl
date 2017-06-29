module RbVHDL::Ast

  module Declaration

    class SubtypeDecl

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{keyword} %{identifier} is %{type};",
        :keyword_format       => "%<keyword>-9s",
        :identifier_format    => "%{identifier}",
        :identifier_separator => ",",
        :identifier_align     => true,
        :type_format          => "%{type}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words    ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format ])
        type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format       ])

        keyword           = keyword_format    % {:keyword    => reserved_words[:subtype]           }
        identifier        = identifier_format % {:identifier => _write_identifier_string(directive)}
        type              = type_format       % {:type       => _write_type_string(directive)      }

        return [ format % {:indent => indent, :keyword => keyword, :identifier => identifier, :type => type} ]
      end

      def _write_identifier_string(directive={})
        return @_identifier._write_string
      end

      def _write_type_string(directive={})
        return @_subtype_indication._write_string
      end
    end

  end
end
