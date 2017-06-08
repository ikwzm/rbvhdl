module RbVHDL::Ast::Declaration

  class File

    WRITE_DIRECTIVE = {
      :keyword              => "file",
      :format               => "%{indent}%{keyword}%{identifier}:  %{type}%{value};",
      :keyword_format       => "%<keyword>-10s",
      :identifier_format    => "%{identifier}",
      :identifier_separator => ",",
      :identifier_align     => true,
      :type_format          => "%{type}",
      :is_keyword           => "is",
      :open_keyword         => "open",
      :value_format         => " %{file_open_kind_expression}%{is_keyword} %{string_expression}",
    }

    def _write_line(directive={})
      indent            = directive.fetch(:indent   , "")
      format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
      keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
      identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format ])
      type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format       ])
      value_format      = directive.fetch(:value_format     , WRITE_DIRECTIVE[:value_format      ])
      file_keyword      = directive.fetch(:file_keyword     , WRITE_DIRECTIVE[:keyword           ])
      is_keyword        = directive.fetch(:is_keyword       , WRITE_DIRECTIVE[:is_keyword        ])
      open_keyword      = directive.fetch(:open_keyword     , WRITE_DIRECTIVE[:open_keyword      ])
      keyword           = keyword_format    % {:keyword    => file_keyword                   }
      identifier        = identifier_format % {:identifier => _write_identifier_string(directive)}
      type              = type_format       % {:type       => _write_type_string(directive)      }
      if @_string_expression.nil? then
        value = ""
      else
        if @_open_expression.nil? then
          file_open_kind_expression = ""
        else
          file_open_kind_expression = " #{open_keyword} #{@_open_expression._write_string}"
        end
        value  = value_format % {:file_open_kind_expression   => file_open_kind_expression, 
                                 :is_keyword                  => is_keyword,
                                 :string_expression           => @_string_expression._write_string
                                }
      end
      return [ format % {indent: indent, keyword: keyword, identifier: identifier, mode: mode, type: type, value: value} ]
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

