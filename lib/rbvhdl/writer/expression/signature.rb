module RbVHDL::Ast

  class Expression

    class Signature
      WRITE_DIRECTIVE = {
        :reserved_words           => RbVHDL::Writer::RESERVED_WORDS,
        :format                   => "[ %{parameter_type?}%{return_type?} ]",
        :parameter_type_format    => "%{type_mark}",
        :return_type_format       => "%{_return_} %{type_mark}",
        :parameter_type_separator => ", ",
      }

      def _write_string(directive={})
        format                   = directive.fetch(:format                  , WRITE_DIRECTIVE[:format                  ])
        reserved_words           = directive.fetch(:reserved_words          , WRITE_DIRECTIVE[:reserved_words          ])
        parameter_type_format    = directive.fetch(:parameter_type_format   , WRITE_DIRECTIVE[:parameter_type_format   ])
        return_type_format       = directive.fetch(:return_type_format      , WRITE_DIRECTIVE[:return_type_format      ])
        parameter_type_separator = directive.fetch(:parameter_type_separator, WRITE_DIRECTIVE[:parameter_type_separator])

        if @_parameter_type_list.size == 0 then
          parameter_type = ""
        else
          parameter_type = @_parameter_type_list.map{ |type_mark|
                             parameter_type_format % {:type_mark => type_mark._write_string}
                           }
                           .join(parameter_type_separator) + " "
        end

        if @_return_type.nil? then
          return_type    = ""
        else
          return_type    = return_type_format % {:_return_ => reserved_words[:return], :type_mark => @_return_type._write_string}
        end
          
        return format % {:parameter_type? => parameter_type, :return_type? => return_type}
      end
    end
  end
end
