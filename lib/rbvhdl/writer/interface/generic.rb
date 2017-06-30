module RbVHDL::Writer

  module Interface

    module Generic
    
      WRITE_DIRECTIVE = {
        :reserved_words           => RbVHDL::Writer::RESERVED_WORDS,
        :generic_begin_format     => "%{indent}%{generic_indent}%{_generic_}(" , 
        :generic_end_format       => "%{indent}%{generic_indent});", 
        :generic_indent           => "    ",
        :generic_interface_indent => "    ",
        :generic_separator        => ";"   ,
      }
    
      module WriteInterface

        def _write_generic_interface(directive={})
          write_line = []
          if @_generic_interface_list.size > 0 then
            indent                   = directive.fetch(:indent, "")
            reserved_words           = directive.fetch(:reserved_words          , self.class::WRITE_DIRECTIVE[:reserved_words          ])
            generic_begin_format     = directive.fetch(:generic_begin_format    , self.class::WRITE_DIRECTIVE[:generic_begin_format    ])
            generic_end_format       = directive.fetch(:generic_end_format      , self.class::WRITE_DIRECTIVE[:generic_end_format      ])
            generic_indent           = directive.fetch(:generic_indent          , self.class::WRITE_DIRECTIVE[:generic_indent          ])
            generic_interface_indent = directive.fetch(:generic_interface_indent, self.class::WRITE_DIRECTIVE[:generic_interface_indent])
            generic_separator        = directive.fetch(:generic_separator       , self.class::WRITE_DIRECTIVE[:generic_separator       ])

            write_line.push(generic_begin_format % {indent: indent, generic_indent: generic_indent, _generic_: reserved_words[:generic]})

            generic_interface_list   = @_generic_interface_list.select{|interface| interface.class <= RbVHDL::Ast::Interface}
            keyword_field_size       = generic_interface_list.map{|interface| interface._write_keyword_string(   directive).size}.max
            identifier_field_size    = generic_interface_list.map{|interface| interface._write_identifier_string(directive).size}.max
            type_field_size          = generic_interface_list.map{|interface| interface._write_type_string(      directive).size}.max

            generic_directive = directive.dup
            generic_directive[:indent           ] = indent + generic_indent + generic_interface_indent
            generic_directive[:keyword_format   ] = (keyword_field_size > 0)? "%<keyword>-#{keyword_field_size+1}s" : ""
            generic_directive[:identifier_format] = "%<identifier>-#{((((identifier_field_size+1).to_f/8).ceil)*8)-1}s"
            generic_directive[:mode_format      ] = ":  "
            generic_directive[:type_format      ] = "%<type>-#{type_field_size}s"

            generic_last_index = 0
            @_generic_interface_list.each_with_index do |interface, index|
              if interface.class <= RbVHDL::Ast::Interface then
                generic_last_index = index
              end
            end

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

    
