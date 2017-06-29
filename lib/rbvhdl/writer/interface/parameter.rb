module RbVHDL::Writer

  module Interface

    module Parameter

      WRITE_DIRECTIVE = {
        :reserved_words         => RbVHDL::Writer::RESERVED_WORDS,
        :param_begin_format     => "%{indent}%{param_indent}%{_parameter_}(" , 
        :param_end_format       => "%{indent}%{param_indent})%{return}", 
        :param_indent           => "",
        :param_interface_indent => "    ",
        :param_separator        => ";"   ,
        :return_format          => "%{_return_} %{return_type}",
        :return_type_format     => "%{type}",
      }
    
      module WriteInterface

        def _write_parameter_interface(directive={})
          write_line = []

          if @_parameter_interface_list.size > 0 then
            indent                  = directive.fetch(:indent, "")
            reserved_words          = directive.fetch(:reserved_words        , self.class::WRITE_DIRECTIVE[:reserved_words        ])
            param_keyword           = directive.fetch(:param_keyword         , self.class::WRITE_DIRECTIVE[:param_keyword         ])
            param_begin_format      = directive.fetch(:param_begin_format    , self.class::WRITE_DIRECTIVE[:param_begin_format    ])
            param_end_format        = directive.fetch(:param_end_format      , self.class::WRITE_DIRECTIVE[:param_end_format      ])
            param_indent            = directive.fetch(:param_indent          , self.class::WRITE_DIRECTIVE[:param_indent          ])
            param_interface_indent  = directive.fetch(:param_interface_indent, self.class::WRITE_DIRECTIVE[:param_interface_indent])
            param_separator         = directive.fetch(:param_separator       , self.class::WRITE_DIRECTIVE[:param_separator       ])
            param_keyword_format    = directive.fetch(:param_keyword_format  , nil)
            param_identifier_format = directive.fetch(:param_identifer_format, nil)
            param_mode_format       = directive.fetch(:param_mode_format     , nil)
            param_type_format       = directive.fetch(:param_type_format     , nil)
            return_type             = directive.fetch(:return_type           , nil)
            return_format           = directive.fetch(:return_format         , nil)

            if param_keyword_format.nil? then
              keyword_max_size        = @_parameter_interface_list.map{|interface| interface._write_keyword_string(   directive).size}.max
              keyword_field_size      = (keyword_max_size < 10) ? 10 : keyword_max_size+1
              param_keyword_format    = "%<keyword>-#{keyword_field_size}s"
            end
              
            if param_identifier_format.nil? then
              identifier_max_size     = @_parameter_interface_list.map{|interface| interface._write_identifier_string(directive).size}.max
              identifier_field_size   = ((((identifier_max_size+1).to_f/8).ceil)*8)-1
              param_identifier_format = "%<identifier>-#{identifier_field_size}s"
            end

            if param_mode_format.nil? then
              param_mode_max_size     = @_parameter_interface_list.map{|interface| interface._write_mode_string(      directive).size}.max
              if    param_mode_max_size < 1 then
                param_mode_format     = ":  "
              elsif param_mode_max_size < 4 then
                param_mode_format     = ":  %<mode>-4s"
              else
                param_mode_format     = ":  %<mode>-#{param_mode_max_size+1}s"
              end
            end

            if param_type_format.nil? then
              param_type_max_size     = @_parameter_interface_list.map{|interface| interface._write_type_string(      directive).size}.max
              with_value_type_format  = "%<type>-#{param_type_max_size}s"
              none_value_type_format  = "%{type}"
            else
              with_value_type_format  = param_type_format
              none_value_type_format  = param_type_format
            end
              
            param_directive = directive.dup
            param_directive[:indent           ] = indent + param_indent + param_interface_indent
            param_directive[:keyword_format   ] = param_keyword_format
            param_directive[:identifier_format] = param_identifier_format
            param_directive[:mode_format      ] = param_mode_format

            write_line.push(param_begin_format % {indent: indent, param_indent: param_indent, _parameter_: ""})

            param_last_index = @_parameter_interface_list.size - 1
            @_parameter_interface_list.each_with_index do |interface, index|
              if index < param_last_index then
                param_directive[:separator] = param_separator
              else
                param_directive[:separator] = ""
              end
              if interface._static_expression.nil? then
                param_directive[:type_format] = none_value_type_format
              else
                param_directive[:type_format] = with_value_type_format
              end
              write_line.concat(interface._write_line(param_directive))
            end

            if    return_type.nil? then
              return_string = ""
            elsif return_format.nil? then
              return_format      = RbVHDL::Ast::Interface::WRITE_DIRECTIVE[:format]
              return_indent      = param_interface_indent.chop
              return_mode_format = param_mode_format.gsub(/:/, " ")
              return_string      = return_format % {:indent     => return_indent,
                                                    :keyword    => param_keyword_format    % {:keyword    => ""                     },
                                                    :identifier => param_identifier_format % {:identifier => reserved_words[:return]},
                                                    :mode       => return_mode_format      % {:mode       => ""                     },
                                                    :type       => return_type._write_string,
                                                    :value      => "",
                                                    :separator  => ""
              }
            else
              return_string = return_format % {:_return_ => reserved_words[:return], :return_type => return_type._write_string}
            end

            write_line.push(param_end_format % {:indent => indent, :param_indent =>  param_indent, :return => return_string})
          end

          return write_line
        end
      end
    end
  end
end

