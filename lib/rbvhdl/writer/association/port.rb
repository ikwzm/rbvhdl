module RbVHDL::Writer

  module Association

    module Port

      WRITE_DIRECTIVE = {
        :port_keyword                    => "port",
        :map_keyword                     => "map",
        :port_map_keyword_format         => "%{port_keyword} %{map_keyword}",
        :port_map_begin_format           => "%{indent}%{port_map_indent}%{port_map_keyword}(" , 
        :port_map_end_format             => "%{indent}%{port_map_indent})%{separator}", 
        :port_map_indent                 => "    ",
        :port_association_indent         => "    ",
        :port_association_separator      => ","   ,
      }

      module WriteAssociation

        def _write_port_association(directive={})
          write_line = []
          if @_port_association_list.size > 0 then
            indent                  = directive.fetch(:indent   , "")
            separator               = directive.fetch(:separator, "")
            port_keyword            = directive.fetch(:port_keyword                  , self.class::WRITE_DIRECTIVE[:port_keyword                  ])
            map_keyword             = directive.fetch(:map_keyword                   , self.class::WRITE_DIRECTIVE[:map_keyword                   ])
            port_map_keyword_format = directive.fetch(:port_map_keyword_format       , self.class::WRITE_DIRECTIVE[:port_map_keyword_format       ])
            port_map_begin_format   = directive.fetch(:port_map_begin_format         , self.class::WRITE_DIRECTIVE[:port_map_begin_format         ])
            port_map_end_format     = directive.fetch(:port_map_end_format           , self.class::WRITE_DIRECTIVE[:port_map_end_format           ])
            port_map_indent         = directive.fetch(:port_map_indent               , self.class::WRITE_DIRECTIVE[:port_map_indent               ])
            association_indent      = directive.fetch(:port_association_indent       , self.class::WRITE_DIRECTIVE[:port_association_indent       ])
            association_separator   = directive.fetch(:port_association_separator    , self.class::WRITE_DIRECTIVE[:port_association_separator    ])
            formal_format           = directive.fetch(:port_association_formal_format, self.class::WRITE_DIRECTIVE[:port_association_formal_format])
            actual_format           = directive.fetch(:port_association_actual_format, self.class::WRITE_DIRECTIVE[:port_association_actual_format])
            
            write_line.push(port_map_begin_format % {:indent              => indent,
                                                     :port_map_indent  => port_map_indent,
                                                     :port_map_keyword => port_map_keyword_format % {:port_keyword => port_keyword,
                                                                                                     :map_keyword  => map_keyword  }})

            
            association_directive          = directive.dup
            association_directive[:indent] = indent + port_map_indent + association_indent

            if formal_format.nil? then
              formal_field_size = @_port_association_list.map{|assoc| assoc._write_formal_part_string.size}.max
              association_directive[:formal_format] = "%<formal>-#{((((formal_field_size+1).to_f/8).ceil)*8)-1}s => "
            else
              association_directive[:formal_format] = formal_format
            end

            if actual_format.nil? then
              actual_field_size = @_port_association_list.map{|assoc| assoc._write_actual_part_string.size}.max
              association_directive[:actual_format] = "%<actual>-#{((((actual_field_size  ).to_f/8).ceil)*8)  }s"
            else
              association_directive[:actual_format] = actual_format
            end
            
            association_last_index   = @_port_association_list.size - 1
            @_port_association_list.each_with_index do |association, index|
              if index < association_last_index then
                association_directive[:separator] = association_separator
              else
                association_directive[:separator] = ""
              end
              write_line.push(association._write_string(association_directive))
            end
            
            write_line.push(port_map_end_format   % {indent: indent, port_map_indent: port_map_indent, separator: separator})
          end
          return write_line
        end

      end
    end
  end
end
