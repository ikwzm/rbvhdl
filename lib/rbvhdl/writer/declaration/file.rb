module RbVHDL::Ast::Declaration

  class File
    RbVHDL::Writer._write_directive(self, {:keyword              => "file",
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
                                   )
    def _write_line(directive={})
      indent            = directive.fetch(:indent   , "")
      format            = directive.fetch(:format           , self.class._write_directive[:format            ])
      keyword_format    = directive.fetch(:keyword_format   , self.class._write_directive[:keyword_format    ])
      identifier_format = directive.fetch(:identifier_format, self.class._write_directive[:identifier_format ])
      type_format       = directive.fetch(:type_format      , self.class._write_directive[:type_format       ])
      value_format      = directive.fetch(:value_format     , self.class._write_directive[:value_format      ])
      file_keyword      = directive.fetch(:file_keyword     , self.class._write_directive[:keyword           ])
      is_keyword        = directive.fetch(:is_keyword       , self.class._write_directive[:is_keyword        ])
      open_keyword      = directive.fetch(:open_keyword     , self.class._write_directive[:open_keyword      ])
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
      identifier_separator = directive.fetch(:identifier_separator , self.class._write_directive[:identifier_separator])
      return @_identifier_list.map{|identifier| identifier._write_string}.join(identifier_separator)
    end

    def _write_type_string(directive={})
      return @_subtype_indication._write_string
    end
  end
end

