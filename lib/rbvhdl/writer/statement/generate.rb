module RbVHDL::Ast

  module Statement

    class IfGenerate
      WRITE_DIRECTIVE = {
        :reserved_words               => RbVHDL::Writer::RESERVED_WORDS,
        :if_generate_begin_format     => "%{indent}%{label?}%{_if_}%{condition}%{_generate_}",
        :if_generate_end_format       => "%{indent}%{_end_} %{_generate_};",
        :label_format                 => "%{label}: ",
        :condition_format             => " %{expression} ",
        :statement_begin_format       => "%{indent}%{_begin_}",
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
        reserved_words            = directive.fetch(:reserved_words           , WRITE_DIRECTIVE[:reserved_words          ])

        condition   = condition_format % {:expression => @_condition._write_string}
        begin_label = label_format     % {:label      => @_label._write_string    }
        end_label   = @_label._write_string

        write_line.push     if_generate_begin_format % {
          :indent       => indent,
          :label?       => begin_label,
          :_if_         => reserved_words[:if],
          :condition    => condition,
          :_generate_   => reserved_words[:generate],
        }
        if (@_declarative_item_list.size > 0)
          write_line.concat _write_declarative_item_list(directive)
          write_line.push   statement_begin_format % {
            :indent     => indent,
            :_begin_    => reserved_words[:begin]
          }
        end
        write_line.concat   _write_statement_list(directive)
        write_line.push     if_generate_end_format % {
          :indent       => indent,
          :_end_        => reserved_words[:end],
          :_generate_   => reserved_words[:generate],
          :label?       => end_label,
        }
        return write_line
      end
    end

    class ForGenerate
      WRITE_DIRECTIVE = {
        :reserved_words               => RbVHDL::Writer::RESERVED_WORDS,
        :for_generate_begin_format    => "%{indent}%{label?}%{_for_} %{identifier} %{_in_} %{range} %{_generate_}",
        :for_generate_end_format      => "%{indent}%{_end_} %{_generate_};",
        :label_format                 => "%{label}: ",
        :condition_format             => " %{expression} ",
        :statement_begin_format       => "%{indent}%{_begin_}",
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
        reserved_words            = directive.fetch(:reserved_words           , WRITE_DIRECTIVE[:reserved_words           ])

        begin_label = label_format     % {:label      => @_label._write_string    }
        end_label   = @_label._write_string

        write_line.push     for_generate_begin_format % {
          :indent       => indent,
          :label?       => begin_label,
          :_for_        => reserved_words[:for],
          :identifier   => @_index_identifier._write_string,
          :_in_         => reserved_words[:in],
          :range        => @_index_range._write_string,
          :_generate_   => reserved_words[:generate],
        }
        if (@_declarative_item_list.size > 0)
          write_line.concat _write_declarative_item_list(directive)
          write_line.push   statement_begin_format  % {
            :indent     => indent,
            :_begin_    => reserved_words[:begin],
          }
        end
        write_line.concat   _write_statement_list(directive)
        write_line.push     for_generate_end_format % {
          :indent       => indent,
          :_end_        => reserved_words[:end],
          :_generate_   => reserved_words[:generate],
          :label?       => end_label,
        }
        return write_line
      end
    end

  end
end



