module RbVHDL::Ast

  module Statement

    class IfGenerate
      WRITE_DIRECTIVE = {
        :if_keyword                   => "if",
        :generate_keyword             => "generate",
        :begin_keyword                => "begin",
        :end_keyword                  => "end",
        :if_generate_begin_format     => "%{indent}%{label?}%{if_keyword}%{condition}%{generate_keyword}",
        :if_generate_end_format       => "%{indent}%{end_keyword} %{generate_keyword};",
        :label_format                 => "%{label}: ",
        :condition_format             => " %{expression} ",
        :statement_begin_format       => "%{indent}%{begin_keyword}",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line  = []
        indent                    = directive.fetch(:indent   , "")
        label_format              = directive.fetch(:label_format             , WRITE_DIRECTIVE[:label_format            ])
        condition_format          = directive.fetch(:condition_format         , WRITE_DIRECTIVE[:condition_format        ])
        if_generate_begin_format  = directive.fetch(:if_generate_begin_format , WRITE_DIRECTIVE[:if_generate_begin_format])
        if_generate_end_format    = directive.fetch(:if_generate_end_format   , WRITE_DIRECTIVE[:if_generate_end_format  ])
        statement_begin_format    = directive.fetch(:statement_begin_format   , WRITE_DIRECTIVE[:statement_begin_format  ])
        statement_indent          = directive.fetch(:statement_indent         , WRITE_DIRECTIVE[:statement_indent        ])
        if_keyword                = directive.fetch(:if_keyword               , WRITE_DIRECTIVE[:if_keyword              ])
        generate_keyword          = directive.fetch(:generate_keyword         , WRITE_DIRECTIVE[:generate_keyword        ])
        begin_keyword             = directive.fetch(:begin_keyword            , WRITE_DIRECTIVE[:begin_keyword           ])
        end_keyword               = directive.fetch(:end_keyword              , WRITE_DIRECTIVE[:end_keyword             ])

        condition   = condition_format % {:expression => @_condition._write_string}
        begin_label = label_format     % {:label      => @_label._write_string    }
        end_label   = @_label._write_string

        write_line.push     if_generate_begin_format % {
          :indent           => indent,
          :label?           => begin_label,
          :if_keyword       => if_keyword,
          :condition        => condition,
          :generate_keyword => generate_keyword,
        }
        if (@_declarative_item_list.size > 0)
          write_line.concat _write_declarative_item_list(directive)
          write_line.push   statement_begin_format % {
            :indent         => indent,
            :begin_keyword  => begin_keyword
          }
        end
        write_line.concat   _write_statement_list(directive)
        write_line.push     if_generate_end_format % {
          :indent           => indent,
          :end_keyword      => end_keyword,
          :generate_keyword => generate_keyword,
          :label?           => end_label,
        }
        return write_line
      end
    end

    class ForGenerate
      WRITE_DIRECTIVE = {
        :for_keyword                  => "for",
        :generate_keyword             => "generate",
        :begin_keyword                => "begin",
        :end_keyword                  => "end",
        :in_keyword                   => "in",
        :for_generate_begin_format    => "%{indent}%{label?}%{for_keyword} %{identifier} %{in_keyword} %{range} %{generate_keyword}",
        :for_generate_end_format      => "%{indent}%{end_keyword} %{generate_keyword};",
        :label_format                 => "%{label}: ",
        :condition_format             => " %{expression} ",
        :statement_begin_format       => "%{indent}%{begin_keyword}",
        :statement_indent             => "    ",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line  = []
        indent                    = directive.fetch(:indent   , "")
        label_format              = directive.fetch(:label_format             , WRITE_DIRECTIVE[:label_format             ])
        condition_format          = directive.fetch(:condition_format         , WRITE_DIRECTIVE[:condition_format         ])
        for_generate_begin_format = directive.fetch(:for_generate_begin_format, WRITE_DIRECTIVE[:for_generate_begin_format])
        for_generate_end_format   = directive.fetch(:for_generate_end_format  , WRITE_DIRECTIVE[:for_generate_end_format  ])
        statement_begin_format    = directive.fetch(:statement_begin_format   , WRITE_DIRECTIVE[:statement_begin_format   ])
        statement_indent          = directive.fetch(:statement_indent         , WRITE_DIRECTIVE[:statement_indent         ])
        for_keyword               = directive.fetch(:for_keyword              , WRITE_DIRECTIVE[:for_keyword              ])
        in_keyword                = directive.fetch(:in_keyword               , WRITE_DIRECTIVE[:in_keyword               ])
        generate_keyword          = directive.fetch(:generate_keyword         , WRITE_DIRECTIVE[:generate_keyword         ])
        begin_keyword             = directive.fetch(:begin_keyword            , WRITE_DIRECTIVE[:begin_keyword            ])
        end_keyword               = directive.fetch(:end_keyword              , WRITE_DIRECTIVE[:end_keyword              ])

        begin_label = label_format     % {:label      => @_label._write_string    }
        end_label   = @_label._write_string

        write_line.push     for_generate_begin_format % {
          :indent           => indent,
          :label?           => begin_label,
          :for_keyword      => for_keyword,
          :identifier       => @_index_identifier._write_string,
          :in_keyword       => in_keyword,
          :range            => @_index_range._write_string,
          :generate_keyword => generate_keyword,
        }
        if (@_declarative_item_list.size > 0)
          write_line.concat _write_declarative_item_list(directive)
          write_line.push   statement_begin_format  % {
            :indent         => indent,
            :begin_keyword  => begin_keyword
          }
        end
        write_line.concat   _write_statement_list(directive)
        write_line.push     for_generate_end_format % {
          :indent           => indent,
          :end_keyword      => end_keyword,
          :generate_keyword => generate_keyword,
          :label?           => end_label,
        }
        return write_line
      end
    end

  end
end



