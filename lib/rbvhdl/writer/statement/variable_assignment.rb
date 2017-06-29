module RbVHDL::Ast

  module Statement

    class SimpleVariableAssignment

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{target}:=%{value};",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :value_format         => " %{expression}",
        :target_align         => true,
      }

      def _write_line(directive={})
        indent        = directive.fetch(:indent   , "")
        format        = directive.fetch(:format       , WRITE_DIRECTIVE[:format       ])
        label_format  = directive.fetch(:label_format , WRITE_DIRECTIVE[:label_format ])
        target_format = directive.fetch(:target_format, WRITE_DIRECTIVE[:target_format])
        value_format  = directive.fetch(:value_format , WRITE_DIRECTIVE[:value_format ])

        label  = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        target = target_format % {:target     => @_target._write_string}
        value  = value_format  % {:expression => @_value._write_string }

        return [ format % {:indent => indent, :label? => label, :target => target, :value => value} ]
      end
    end

    class ConditionalVariableAssignment

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{target}:=%{value};",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :value_format         => " %{expression}%{when?}",
        :when_format          => " %{_when_} %{condition}",
        :target_align         => true,
      }

      def _write_line(directive={})
        write_line     = []
        indent         = directive.fetch(:indent   , "")
        format         = directive.fetch(:format       , WRITE_DIRECTIVE[:format       ])
        label_format   = directive.fetch(:label_format , WRITE_DIRECTIVE[:label_format ])
        target_format  = directive.fetch(:target_format, WRITE_DIRECTIVE[:target_format])
        value_format   = directive.fetch(:value_format , WRITE_DIRECTIVE[:value_format ])
        when_format    = directive.fetch(:when_format  , WRITE_DIRECTIVE[:when_format  ])
        reserved_words = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        expression_max_size = @_value_list.map{|value| value[0]._write_string.size}.max
        condition_max_size  = @_value_list.map{|value| value[1]._write_string.size}.max
        expression_format   = "%<expression>-#{expresion_max_size+1}s"
        condition_format    = "%<expression>-#{condition_max_size}s"
        
        label  = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        target = target_format % {:target     => @_target._write_string}

        else_indent_size = (format % {:indent => indent, :label? => label, :target => target, :value  => ""}).size-1
        else_indent      = " " * else_indent_size
        else_separator   = " #{reserved_words[:else]}\n#{else_indent}"

        value_string     = @_value_list.map{ |value_pair|
          expression = value_pair[0]
          condition  = value_pair[1]
          if condition.nil? then
            when_string = ""
          else
            when_string = when_format % {:_when_    => reserved_words[:when],
                                         :condition => condition_format % {:expression => condition._write_string}}
          end
          value_format % {:expression => expression._write_string, :when? => when_string}
        }.join(else_separator)

        return format % {:indent => indent, :label? => label, :target => target, :value => value_string}.split(/\n/)
      end
    end
    
    class SelectedVariableAssignment
    end

  end
end

    
    
