module RbVHDL::Writer

  module Association

    module Parameter

      WRITE_DIRECTIVE = {
        :parameter_begin_format          => "%{indent}(" , 
        :parameter_end_format            => "%{indent})%{separator}", 
        :parameter_association_indent    => "    ",
        :parameter_association_separator => ","   ,
      }

      module WriteAssociation

        def _write_parameter_association(directive={})
          write_line = []
          if @_parameter_association_list.size > 0 then
            indent                = directive.fetch(:indent   , "")
            separator             = directive.fetch(:separator, "")
            param_begin_format    = directive.fetch(:parameter_begin_format             , self.class::WRITE_DIRECTIVE[:parameter_begin_format             ])
            param_end_format      = directive.fetch(:parameter_end_format               , self.class::WRITE_DIRECTIVE[:parameter_end_format               ])
            association_indent    = directive.fetch(:parameter_association_indent       , self.class::WRITE_DIRECTIVE[:parameter_association_indent       ])
            association_separator = directive.fetch(:parameter_association_separator    , self.class::WRITE_DIRECTIVE[:parameter_association_separator    ])
            formal_format         = directive.fetch(:parameter_association_formal_format, self.class::WRITE_DIRECTIVE[:parameter_association_formal_format])
            actual_format         = directive.fetch(:parameter_association_actual_format, self.class::WRITE_DIRECTIVE[:parameter_association_actual_format])
            
            write_line.push(param_begin_format % {:indent => indent})
            
            association_directive          = directive.dup
            association_directive[:indent] = indent + association_indent

            if formal_format.nil? then
              formal_field_size = @_parameter_association_list.map{|assoc| assoc._write_formal_part_string.size}.max
              association_directive[:formal_format] = "%<formal>-#{((((formal_field_size+1).to_f/8).ceil)*8)-1}s => "
            else
              association_directive[:formal_format] = formal_format
            end

            if actual_format.nil? then
              actual_field_size = @_parameter_association_list.map{|assoc| assoc._write_actual_part_string.size}.max
              association_directive[:actual_format] = "%<actual>-#{((((actual_field_size  ).to_f/8).ceil)*8)  }s"
            else
              association_directive[:actual_format] = actual_format
            end
            
            association_last_index = @_parameter_association_list.size - 1
            @_parameter_association_list.each_with_index do |association, index|
              if index < association_last_index then
                association_directive[:separator] = association_separator
              else
                association_directive[:separator] = ""
              end
              write_line.push(association._write_string(association_directive))
            end
            
            write_line.push(param_end_format   % {indent: indent, separator: separator})
          end
          return write_line
        end

      end
    end
  end
end
