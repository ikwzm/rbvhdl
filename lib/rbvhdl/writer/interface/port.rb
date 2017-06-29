module RbVHDL::Writer

  module Interface

    module Port

      WRITE_DIRECTIVE = {
        :reserved_words           => RbVHDL::Writer::RESERVED_WORDS,
        :port_begin_format        => "%{indent}%{port_indent}%{_port_}(",
        :port_end_format          => "%{indent}%{port_indent});",
        :port_indent              => "    ",
        :port_interface_indent    => "    ",
        :port_separator           => ";"   ,
      }

      module WriteInterface

        def _write_port_interface(directive={})
          write_line = []
          if @_port_interface_list.size > 0 then
            indent                = directive.fetch(:indent, "")
            reserved_words        = directive.fetch(:reserved_words       , self.class::WRITE_DIRECTIVE[:reserved_words       ])
            port_begin_format     = directive.fetch(:port_begin_format    , self.class::WRITE_DIRECTIVE[:port_begin_format    ])
            port_end_format       = directive.fetch(:port_end_format      , self.class::WRITE_DIRECTIVE[:port_end_format      ])
            port_indent           = directive.fetch(:port_indent          , self.class::WRITE_DIRECTIVE[:port_indent          ])
            port_interface_indent = directive.fetch(:port_interface_indent, self.class::WRITE_DIRECTIVE[:port_interface_indent])
            port_separator        = directive.fetch(:port_separator       , self.class::WRITE_DIRECTIVE[:port_separator       ])
  
            write_line.push(port_begin_format % {indent: indent, port_indent: port_indent, _port_: reserved_words[:port]})

            keyword_field_size    = @_port_interface_list.map{|interface| interface._write_keyword_string(   directive).size}.max
            identifier_field_size = @_port_interface_list.map{|interface| interface._write_identifier_string(directive).size}.max
            type_field_size       = @_port_interface_list.map{|interface| interface._write_type_string(      directive).size}.max
            mode_field_size       = @_port_interface_list.map{|interface| interface._write_mode_string(      directive).size}.max
            mode_field_size       = 3 if mode_field_size < 3

            port_directive = directive.dup
            port_directive[:indent           ] = indent + port_indent + port_interface_indent
            port_directive[:keyword_format   ] = (keyword_field_size > 0)? "%<keyword>-#{keyword_field_size+1}s" : ""
            port_directive[:identifier_format] = "%<identifier>-#{((((identifier_field_size+1).to_f/8).ceil)*8)-1}s"
            port_directive[:mode_format      ] = ":  %<mode>-#{mode_field_size+1}s"
            port_directive[:type_format      ] = "%{type}"

            port_last_index       = @_port_interface_list.size - 1
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
