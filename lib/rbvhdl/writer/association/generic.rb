module RbVHDL::Writer

  module Association

    module Generic

      WRITE_DIRECTIVE = {
        :generic_keyword               => "generic",
        :map_keyword                   => "map",
        :generic_map_keyword_format    => "%{generic_keyword} %{map_keyword}",
        :generic_map_begin_format      => "%{indent}%{generic_map_indent}%{generic_map_keyword}(" , 
        :generic_map_end_format        => "%{indent}%{generic_map_indent})%{separator}", 
        :generic_map_indent            => "    ",
        :generic_association_indent    => "    ",
        :generic_association_separator => ","   ,
      }

      module WriteAssociation

        def _write_generic_association(directive={})
          write_line = []
          if @_generic_association_list.size > 0 then
            indent                        = directive.fetch(:indent   , "")
            separator                     = directive.fetch(:separator, "")
            generic_keyword               = directive.fetch(:generic_keyword              , self.class::WRITE_DIRECTIVE[:generic_keyword              ])
            map_keyword                   = directive.fetch(:map_keyword                  , self.class::WRITE_DIRECTIVE[:map_keyword                  ])
            generic_map_keyword_format    = directive.fetch(:generic_map_keyword_format   , self.class::WRITE_DIRECTIVE[:generic_map_keyword_format   ])
            generic_map_begin_format      = directive.fetch(:generic_map_begin_format     , self.class::WRITE_DIRECTIVE[:generic_map_begin_format     ])
            generic_map_end_format        = directive.fetch(:generic_map_end_format       , self.class::WRITE_DIRECTIVE[:generic_map_end_format       ])
            generic_map_indent            = directive.fetch(:generic_map_indent           , self.class::WRITE_DIRECTIVE[:generic_map_indent           ])
            generic_association_indent    = directive.fetch(:generic_association_indent   , self.class::WRITE_DIRECTIVE[:generic_association_indent   ])
            generic_association_separator = directive.fetch(:generic_association_separator, self.class::WRITE_DIRECTIVE[:generic_association_separator])
            
            write_line.push(generic_map_begin_format % {:indent              => indent,
                                                        :generic_map_indent  => generic_map_indent,
                                                        :generic_map_keyword => generic_map_keyword_format % {:generic_keyword => generic_keyword,
                                                                                                              :map_keyword     => map_keyword     }})

            
            formal_part_field_size   = @_generic_association_list.map{|assoc| assoc._write_formal_part_string.size}.max
            actual_part_field_size   = @_generic_association_list.map{|assoc| assoc._write_actual_part_string.size}.max

            association_directive                 = directive.dup
            association_directive[:indent       ] = indent + generic_map_indent + generic_association_indent
            association_directive[:formal_format] = "%<formal>-#{((((formal_part_field_size+1).to_f/8).ceil)*8)-1}s => "
            association_directive[:actual_format] = "%<actual>-#{((((actual_part_field_size  ).to_f/8).ceil)*8)  }s"
            
            association_last_index   = @_generic_association_list.size - 1
            @_generic_association_list.each_with_index do |association, index|
              if index < association_last_index then
                association_directive[:separator] = generic_association_separator
              else
                association_directive[:separator] = ""
              end
              write_line.push(association._write_string(association_directive))
            end
            
            write_line.push(generic_map_end_format   % {indent: indent, generic_map_indent: generic_map_indent, separator: separator})
          end
          return write_line
        end

      end
    end
  end
end

      
