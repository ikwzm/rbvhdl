module RbVHDL::Ast::Declaration

  class Signal

    WRITE_DIRECTIVE = {
      :keyword              => "signal",
      :format               => "%{indent}%{keyword}%{identifier}:  %{type}%{value};",
      :keyword_format       => "%<keyword>-10s",
      :identifier_format    => "%{identifier}",
      :identifier_separator => ",",
      :identifier_align     => true,
      :type_format          => "%{type}",
      :value_format         => " := %{expression}",
    }

    def _write_line(directive={})
      indent            = directive.fetch(:indent   , "")
      format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
      keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
      identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format ])
      type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format       ])
      value_format      = directive.fetch(:value_format     , WRITE_DIRECTIVE[:value_format      ])
      signal_keyword    = directive.fetch(:signal_keyword   , WRITE_DIRECTIVE[:keyword           ])
      keyword           = keyword_format    % {:keyword    => signal_keyword                     }
      identifier        = identifier_format % {:identifier => _write_identifier_string(directive)}
      type              = type_format       % {:type       => _write_type_string(directive)      }
      value             = (@_value_expression.nil?)?  "" : value_format % {:expression => @_value_expression._write_string}
      return [ format % {indent: indent, keyword: keyword, identifier: identifier, type: type, value: value} ]
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

