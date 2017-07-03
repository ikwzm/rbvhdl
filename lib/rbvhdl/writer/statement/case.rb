require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Statement

    class Case
      class When
        WRITE_DIRECTIVE = {
          :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
          :when_format        => "%{indent}%{_when_} %{choices} =>",
          :choices_format     => "%{choices}",
        }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE)
        include  RbVHDL::Writer::Statement::WriteStatementList
        
        def _write_line(directive={})
          write_line = []
          indent         = directive.fetch(:indent   , "")
          when_format    = directive.fetch(:when_format      , WRITE_DIRECTIVE[:when_format      ])
          choices_format = directive.fetch(:choices_format   , WRITE_DIRECTIVE[:choices_format   ])
          reserved_words = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])
          choices        = choices_format % {choices: @_choices._write_string }
          write_line.push   when_format % {indent: indent, _when_: reserved_words[:when], choices: choices}
          write_line.concat _write_statement_list(directive)
          return write_line
        end

        def _write_choices_string(directive={})
          return @_choices._write_string
        end
      end

      WRITE_DIRECTIVE = {
        :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
        :label_format       => "%{label}: ",
        :case_begin_format  => "%{indent}%{label?}%{_case_} %{expression} %{_is_}",
        :case_end_format    => "%{indent}%{_end_} %{_case_};",
        :when_indent        => "    ",
      }

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        case_begin_format = directive.fetch(:case_begin_format, WRITE_DIRECTIVE[:case_begin_format])
        case_end_format   = directive.fetch(:case_end_format  , WRITE_DIRECTIVE[:case_end_format  ])
        when_indent       = directive.fetch(:when_indent      , WRITE_DIRECTIVE[:when_indent      ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        begin_label = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label   = (@_label.nil?)? "" :                           @_label._write_string
        expression  = @_expression._write_string

        write_line.push  case_begin_format  % {
          :indent       => indent,
          :label?       => begin_label,
          :_case_       => reserved_words[:case],
          :expression   => expression,
          :_is_         => reserved_words[:is],
        }
        
        if @_when_list.size > 0 then
          choices_field_size = @_when_list.map{|_when| _when._write_choices_string.size}.max
          target_field_size  = @_when_list.map{|_when| _when._target_field_max_size    }.max
          when_directive = directive.dup
          when_directive[:indent] = indent + when_indent
          if choices_field_size > 0 then
            when_directive[:choices_format] = "%<choices>-#{choices_field_size}s"
          else
            when_directive.delete(:choices_format)
          end
          if target_field_size > 0 then
            when_directive[:target_format ] = "%<target>-#{target_field_size+1}s"
          else
            when_directive.delete(:target_format)
          end
          
          @_when_list.each do |_when|
            write_line.concat _when._write_line(when_directive) 
          end
        end
        
        write_line.push  case_end_format    % {
          :indent       => indent,
          :label?       => end_label,
          :_case_       => reserved_words[:case],
          :_end_        => reserved_words[:end],
        }
        return write_line
      end
    end

  end
end
