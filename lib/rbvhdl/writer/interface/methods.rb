module RbVHDL::Writer
  module Interface
    module Methods

      module WriteLine

        def _write_line(directive={})
          indent               = directive.fetch(:indent   , "")
          separator            = directive.fetch(:separator, ";")
          format               = directive.fetch(:format           , self.class::WRITE_DIRECTIVE[:format            ])
          keyword_format       = directive.fetch(:keyword_format   , self.class::WRITE_DIRECTIVE[:keyword_format    ])
          identifier_format    = directive.fetch(:identifier_format, self.class::WRITE_DIRECTIVE[:identifier_format ])
          mode_format          = directive.fetch(:mode_format      , self.class::WRITE_DIRECTIVE[:mode_format       ])
          type_format          = directive.fetch(:type_format      , self.class::WRITE_DIRECTIVE[:type_format       ])
          value_format         = directive.fetch(:value_format     , self.class::WRITE_DIRECTIVE[:value_format      ])
          keyword              = keyword_format    % {:keyword    => self.class::WRITE_DIRECTIVE[:keyword]}
          identifier           = identifier_format % {:identifier => _write_identifier_string(directive)  }
          mode                 = mode_format       % {:mode       => _write_mode_string(directive)        }
          type                 = type_format       % {:type       => _write_type_string(directive)        }
          value                = (@_static_expression.nil?)?  "" : value_format % {:expression => @_static_expression._write_string}
          return [ format % {indent: indent, keyword: keyword, identifier: identifier, mode: mode, type: type, value: value, separator: separator} ]
        end

        def _write_identifier_string(directive={})
          identifier_separator = directive.fetch(:identifier_separator , self.class::WRITE_DIRECTIVE[:identifier_separator])
          return @_identifier_list.map{|identifier| identifier._write_string}.join(identifier_separator)
        end

        def _write_mode_string(directive={})
          return (@_mode.nil?)?  "" : @_mode.to_s
        end

        def _write_type_string(directive={})
          return @_subtype_indication._write_string
        end
      end

      module GenericInterfaceList

        def _write_generic_interface(directive={})
          write_line = []
          if @_generic_interface_list.size > 0 then
            indent                     = directive.fetch(:indent, "")
            generic_keyword            = directive.fetch(:generic_keyword         , self.class::WRITE_DIRECTIVE[:generic_keyword         ])
            generic_begin_format       = directive.fetch(:generic_begin_format    , self.class::WRITE_DIRECTIVE[:generic_begin_format    ])
            generic_end_format         = directive.fetch(:generic_end_format      , self.class::WRITE_DIRECTIVE[:generic_end_format      ])
            generic_indent             = directive.fetch(:generic_indent          , self.class::WRITE_DIRECTIVE[:generic_indent          ])
            generic_interface_indent   = directive.fetch(:generic_interface_indent, self.class::WRITE_DIRECTIVE[:generic_interface_indent])
            generic_separator          = directive.fetch(:generic_separator       , self.class::WRITE_DIRECTIVE[:generic_separator       ])

            write_line.push(generic_begin_format % {indent: indent, generic_indent: generic_indent, generic_keyword: generic_keyword})

            identifier_field_max_size  = 0
            type_field_max_size        = 0
            @_generic_interface_list.each do |interface|
              identifier_field_size     = interface._write_identifier_string.size
              type_field_size           = interface._write_type_string.size
              identifier_field_max_size = identifier_field_size if(identifier_field_size > identifier_field_max_size)
              type_field_max_size       = type_field_size       if(type_field_size       > type_field_max_size      )
            end

            generic_directive = directive.dup
            generic_directive[:indent           ] = indent + generic_indent + generic_interface_indent
            generic_directive[:keyword_format   ] = ""
            generic_directive[:identifier_format] = "%<identifier>-#{((identifier_field_max_size.to_f/8).ceil)*8}s"
            generic_directive[:mode_format      ] = " :  "
            generic_directive[:type_format      ] = "%<type>-#{type_field_max_size}s"

            generic_last_index         = @_generic_interface_list.size - 1
            @_generic_interface_list.each_with_index do |interface, index|
              if index < generic_last_index then
                generic_directive[:separator] = generic_separator
              else
                generic_directive[:separator] = ""
              end
              write_line.concat(interface._write_line(generic_directive))
            end

            write_line.push(generic_end_format   % {indent: indent, generic_indent: generic_indent})
          end
          return write_line
        end
      end

      module PortInterfaceList

        def _write_port_interface(directive={})
          write_line = []
          if @_port_interface_list.size > 0 then
            indent                     = directive.fetch(:indent, "")
            port_keyword               = directive.fetch(:port_keyword         , self.class::WRITE_DIRECTIVE[:port_keyword         ])
            port_begin_format          = directive.fetch(:port_begin_format    , self.class::WRITE_DIRECTIVE[:port_begin_format    ])
            port_end_format            = directive.fetch(:port_end_format      , self.class::WRITE_DIRECTIVE[:port_end_format      ])
            port_indent                = directive.fetch(:port_indent          , self.class::WRITE_DIRECTIVE[:port_indent          ])
            port_interface_indent      = directive.fetch(:port_interface_indent, self.class::WRITE_DIRECTIVE[:port_interface_indent])
            port_separator             = directive.fetch(:port_separator       , self.class::WRITE_DIRECTIVE[:port_separator       ])

            write_line.push(port_begin_format % {indent: indent, port_indent: port_indent, port_keyword: port_keyword})

            identifier_field_max_size  = 0
            type_field_max_size        = 0
            mode_field_max_size        = 3
            @_port_interface_list.each do |interface|
              identifier_field_size     = interface._write_identifier_string.size
              type_field_size           = interface._write_type_string.size
              mode_field_size           = interface._write_mode_string.size
              identifier_field_max_size = identifier_field_size if(identifier_field_size > identifier_field_max_size)
              type_field_max_size       = type_field_size       if(type_field_size       > type_field_max_size      )
              mode_field_max_size       = mode_field_size       if(mode_field_size       > mode_field_max_size      )
            end

            port_directive = directive.dup
            port_directive[:indent           ]    = indent + port_indent + port_interface_indent
            port_directive[:keyword_format   ] = ""
            port_directive[:identifier_format] = "%<identifier>-#{((identifier_field_max_size.to_f/8).ceil)*8}s"
            port_directive[:mode_format      ] = " :  %<mode>-#{mode_field_max_size+1}s"
            port_directive[:type_format      ] = "%{type}"

            port_last_index            = @_port_interface_list.size - 1
            @_port_interface_list.each_with_index do |interface, index|
              if index < port_last_index then
                port_directive[:separator] = port_separator
              else
                port_directive[:separator] = ""
              end
              write_line.concat(interface._write_line(port_directive))
            end

            write_line.push(port_end_format   % {indent: indent, port_indent: port_indent})
          end
          return write_line
        end
      end
      
    end
  end
end

    
