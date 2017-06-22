require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Statement

    class Block

      WRITE_DIRECTIVE = {
        :keyword                      => "block",
        :is_keyword                   => "is",
        :begin_keyword                => "begin",
        :end_keyword                  => "end",
        :block_begin_format           => "%{indent}%{label}%{block_keyword}%{guard}",
        :block_end_format             => "%{indent}%{end_keyword} %{block_keyword};",
        :label_format                 => "%{label}",
        :guard_format                 => "(%{expression})",
        :statement_begin_format       => "%{indent}%{begin_keyword}",
        :statement_indent             => "    ",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )

      def _write_line(directive={})
        write_line  = []
        label_format           = directive.fetch(:label_format          , WRITE_DIRECTIVE[:label_format          ])
        guard_format           = directive.fetch(:guard_format          , WRITE_DIRECTIVE[:guard_format          ])
        block_begin_format     = directive.fetch(:block_begin_format    , WRITE_DIRECTIVE[:block_begin_format    ])
        block_end_format       = directive.fetch(:block_end_format      , WRITE_DIRECTIVE[:block_end_format      ])
        statement_begin_format = directive.fetch(:statement_begin_format, WRITE_DIRECTIVE[:statement_begin_format])
        statement_indent       = directive.fetch(:statement_indent      , WRITE_DIRECTIVE[:statement_indent      ])
        block_keyword          = directive.fetch(:block_keyword         , WRITE_DIRECTIVE[:keyword               ])
        is_keyword             = directive.fetch(:is_keyword            , WRITE_DIRECTIVE[:is_keyword            ])
        begin_keyword          = directive.fetch(:begin_keyword         , WRITE_DIRECTIVE[:begin_keyword         ])
        end_keyword            = directive.fetch(:end_keyword           , WRITE_DIRECTIVE[:end_keyword           ])

        begin_label = (@_label.nil?            )? "" : label_format % {:label =>      @_label._write_string            }
        end_label   = (@_label.nil?            )? "" :                                @_label._write_string
        guard       = (@_gurard_expression.nil?)? "" : guard_format % {:expression => @_gurard_expression._write_string}

        write_line.push   block_begin_format     % {
          :indent        => indent,
          :label         => begin_label,
          :block_keyword => block_keyword,
          :is_keyword    => is_keyword,
          :guard         => guard
        }
        write_line.concat _write_declarative_item_list(directive)
        write_line.push   statement_begin_format % {
          :indent        => indent,
          :begin_keyword => begin_keyword
        }
        write_line.concat _write_statement_list(directive)
        write_line.push   block_end_format       % {
          :indent        => indent,
          :label         => end_label,
          :block_keyword => block_keyword,
          :end_keyword   => end_keyword
        }
        return write_line
      end
      
    end

  end
end