module RbVHDL::Writer

  module Interface

    module Port

      WRITE_DIRECTIVE = {
        :port_keyword             => "port",
        :port_begin_format        => "%{indent}%{port_indent}%{port_keyword}(",
        :port_end_format          => "%{indent}%{port_indent});",
        :port_indent              => "    ",
        :port_interface_format    => "%{indent}%<identifier>-15s :  %{mode} %{type}%{value}%{separator}",
        :port_interface_indent    => "    ",
        :port_separator           => ";"   ,
      }

      module WriteInterface

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
            port_directive[:indent           ] = indent + port_indent + port_interface_indent
            port_directive[:keyword_format   ] = ""
            port_directive[:identifier_format] = "%<identifier>-#{((((identifier_field_max_size+1).to_f/8).ceil)*8)-1}s"
            port_directive[:mode_format      ] = ":  %<mode>-#{mode_field_max_size+1}s"
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


