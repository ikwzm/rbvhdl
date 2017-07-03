require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Statement

    class Block

      WRITE_DIRECTIVE = {
        :reserved_words               => RbVHDL::Writer::RESERVED_WORDS,
        :block_begin_format           => "%{indent}%{label?}%{_block_}%{guard?}%{begin?}",
        :block_end_format             => "%{indent}%{_end_} %{_block_};",
        :label_format                 => "%{label}: ",
        :guard_format                 => "(%{expression})",
        :statement_begin_format       => "%{indent}%{_begin_}",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line  = []
        indent                 = directive.fetch(:indent   , "")
        label_format           = directive.fetch(:label_format          , WRITE_DIRECTIVE[:label_format          ])
        guard_format           = directive.fetch(:guard_format          , WRITE_DIRECTIVE[:guard_format          ])
        block_begin_format     = directive.fetch(:block_begin_format    , WRITE_DIRECTIVE[:block_begin_format    ])
        block_end_format       = directive.fetch(:block_end_format      , WRITE_DIRECTIVE[:block_end_format      ])
        statement_begin_format = directive.fetch(:statement_begin_format, WRITE_DIRECTIVE[:statement_begin_format])
        reserved_words         = directive.fetch(:reserved_words        , WRITE_DIRECTIVE[:reserved_words        ])

        begin_label = (@_label.nil?            )? "" : label_format % {:label =>      @_label._write_string            }
        end_label   = (@_label.nil?            )? "" :                                @_label._write_string
        guard       = (@_gurard_expression.nil?)? "" : guard_format % {:expression => @_gurard_expression._write_string}

        if (@_declarative_item_list.size > 0)
          write_line.push   block_begin_format     % {
            :indent   => indent,
            :label?   => begin_label,
            :_block_  => reserved_words[:block],
            :_is_     => reserved_words[:is],
            :guard?   => guard,
            :begin?   => ""
          }
          write_line.concat _write_declarative_item_list(directive)
          write_line.push   statement_begin_format % {
            :indent   => indent,
            :_begin_  => reserved_words[:begin],
          }
        else
          write_line.push   block_begin_format     % {
            :indent   => indent,
            :label?   => begin_label,
            :_block_  => reserved_words[:block],
            :_is_     => reserved_words[:is],
            :guard?   => guard,
            :begin?   => " #{reserved_words[:begin]}"
          }
        end
        write_line.concat _write_statement_list(directive)
        write_line.push   block_end_format       % {
          :indent   => indent,
          :label?   => end_label,
          :_block_  => reserved_words[:block],
          :_end_    => reserved_words[:end],
        }
        return write_line
      end
      
    end

  end
end
