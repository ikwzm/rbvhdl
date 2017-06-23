require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Statement

    class Case
      class When
        WRITE_DIRECTIVE = {
          :when_keyword       => "when",
          :when_format        => "%{indent}%{when_keyword} %{choices} =>",
          :choices_format     => "%{choices}",
        }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE)
        
        def _write_line(directive={})
          write_line = []
          indent            = directive.fetch(:indent   , "")
          when_keyword      = directive.fetch(:when_keyword     , WRITE_DIRECTIVE[:when_keyword     ])
          when_format       = directive.fetch(:when_format      , WRITE_DIRECTIVE[:when_format      ])
          choices_format    = directive.fetch(:choices_format   , WRITE_DIRECTIVE[:choices_format   ])
          choices           = choices_format % {choices: @_choices._write_string }
          write_line.push   when_format % {indent: indent, when_keyword: when_keyword, choices: choices}
          write_line.concat _write_statement_list(directive)
          return write_line
        end

        def _write_choices_string(directive={})
          return @_choices._write_string
        end
        
        include RbVHDL::Writer::Statement::WriteStatementList
      end

      WRITE_DIRECTIVE = {
        :case_keyword       => "case",
        :is_keyword         => "is",
        :label_format       => "%{label}: ",
        :case_begin_format  => "%{indent}%{label?}%{case_keyword} %{expression} %{is_keyword}",
        :case_end_format    => "%{indent}%{end_keyword} %{case_keyword};",
        :when_indent        => "    ",
      }

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        case_keyword      = directive.fetch(:case_keyword     , WRITE_DIRECTIVE[:case_keyword     ])
        is_keyword        = directive.fetch(:is_keyword       , WRITE_DIRECTIVE[:is_keyword       ])
        end_keyword       = directive.fetch(:end_keyword      , WRITE_DIRECTIVE[:end_keyword      ])
        case_begin_format = directive.fetch(:case_begin_format, WRITE_DIRECTIVE[:case_begin_format])
        case_end_format   = directive.fetch(:case_end_format  , WRITE_DIRECTIVE[:case_end_format  ])
        when_indent       = directive.fetch(:when_indent      , WRITE_DIRECTIVE[:when_indent      ])

        begin_label = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label   = (@_label.nil?)? "" :                           @_label._write_string
        expression  = @_expression._write_string

        choices_field_size = @_when_list.map{|_when| _when._write_choices_string.size}.max
        when_directive = directive.dup
        when_directive[:choices_format] = "%<choices>-#{choices_field_size}s"
        when_directive[:indent]         = indent + when_indent
          
        write_line.push( case_begin_format  % {:indent       => indent,
                                               :label?       => begin_label,
                                               :case_keyword => case_keyword,
                                               :expression   => expression,
                                               :is_keyword   => is_keyword })
        @_when_list.each do |_when|
          write_line.concat( _when._write_line(when_directive) )
        end
        write_line.push( case_end_format    % {:indent       => indent,
                                               :label?       => end_label,
                                               :case_keyword => case_keyword,
                                               :end_keyword  => end_keyword })
        return write_line
      end
    end

  end
end
