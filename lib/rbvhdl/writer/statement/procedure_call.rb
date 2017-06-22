require_relative '../association/parameter'

module RbVHDL::Ast

  module Statement

    class ProcedureCall

      WRITE_DIRECTIVE = {
        :format                        => "%{indent}%{label}%{postponed}%{name}%{parameter};",
        :label_format                  => "%{label}: ",
        :name_format                   => "%{name}",
        :parameter_format              => "%{parameter}",
        :postponed_format              => "%{postponed_keyword}",
        :postponed_keyword             => "postponed",
        :parameter_begin_format        => "(",
        :parameter_end_format          => "%{indent})",
        :parameter_association_indent  => "        ",
      }.merge( RbVHDL::Writer::Association::Parameter::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Association::Parameter::WriteAssociation

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , self.class::WRITE_DIRECTIVE[:format           ])
        label_format      = directive.fetch(:label_format     , self.class::WRITE_DIRECTIVE[:label_format     ])
        name_format       = directive.fetch(:name_format      , self.class::WRITE_DIRECTIVE[:name_format      ])
        parameter_format  = directive.fetch(:parameter_format , self.class::WRITE_DIRECTIVE[:parameter_format ])
        postponed_format  = directive.fetch(:postponed_format , self.class::WRITE_DIRECTIVE[:postponed_format ])
        postponed_keyword = directive.fetch(:postponed_keyword, self.class::WRITE_DIRECTIVE[:postponed_keyword])

        parameter_assocation_directive = directive.dup
        if true then
          parameter_assocation_directive[:separator] = ""
          parameter_assocation_directive[:indent   ] = indent
          parameter_assocation_separator = "\n"
        else
          parameter_assocation_directive[:separator] = ""
          parameter_assocation_directive[:indent   ] = ""
          parameter_assocation_directive[:parameter_begin_format             ] = "("
          parameter_assocation_directive[:parameter_end_format               ] = ")"
          parameter_assocation_directive[:parameter_association_indent       ] = ""
          parameter_assocation_directive[:parameter_association_separator    ] = ", "
          parameter_assocation_directive[:parameter_association_formal_format] = "%{formal}=>"
          parameter_assocation_directive[:parameter_association_actual_format] = "%{actual}"
          parameter_assocation_separator = ""
        end

        parameter_string  = _write_parameter_association(parameter_assocation_directive).join(parameter_assocation_separator)
          
        return (format % {
          :indent    => indent,
          :label     => (@_label.nil?    )? "" : label_format     % {:label             => @_label._write_string},
          :postponed => (@_postponed.nil?)? "" : postponed_format % {:postponed_keyword => postponed_keyword    },
          :name      => name_format      % {:name      => @_name._write_string},
          :parameter => parameter_format % {:parameter => parameter_string    },
        }).split(/\n/)
      end
    end
  end
end
