module RbVHDL::Ast

  module Declaration

    class Alias

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{keyword} %{identifier} %{type}%{name};",
        :keyword_format       => "%<keyword>-9s",
        :identifier_format    => "%{identifier}",
        :identifier_align     => true,
        :type_format          => ":  %{type} ",
        :name_format          => "is %{name}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words    ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format ])
        type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format       ])
        name_format       = directive.fetch(:name_format      , WRITE_DIRECTIVE[:name_format       ])
        keyword           = keyword_format    % {:keyword    => reserved_words[:alias]             }
        identifier        = identifier_format % {:identifier => _write_identifier_string(directive)}
        type              = (@_subtype_indication.nil?)? "" : type_format % {:type => _write_type_string(directive)}
        name              = name_format       % {:name       => @_name._write_string               }
        return [ format % {:indent => indent, :keyword => keyword, :identifier => identifier, :type => type, :name => name} ]
      end

      def _write_identifier_string(directive={})
        return @_identifier._write_string
      end

      def _write_type_string(directive={})
        return (@_subtype_indication.nil?)? "" : @_subtype_indication._write_string
      end
    end

  end
end
