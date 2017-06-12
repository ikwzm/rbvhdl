module RbVHDL::Writer

  module Interface

    module Generic
    
      WRITE_DIRECTIVE = {
        :generic_keyword          => "generic",
        :generic_begin_format     => "%{indent}%{generic_indent}%{generic_keyword}(" , 
        :generic_end_format       => "%{indent}%{generic_indent});", 
        :generic_indent           => "    ",
        :generic_interface_format => "%{indent}%<identifier>-15s :  %{type}%{value}%{separator}",
        :generic_interface_indent => "    ",
        :generic_separator        => ";"   ,
      }
    
      module WriteInterface

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
            generic_directive[:identifier_format] = "%<identifier>-#{((((identifier_field_max_size+1).to_f/8).ceil)*8)-1}s"
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
    end
  end
end

    
