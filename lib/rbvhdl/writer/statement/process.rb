require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Statement

    class Process
      WRITE_DIRECTIVE = {
        :keyword                      => "process",
        :is_keyword                   => "is",
        :begin_keyword                => "begin",
        :end_keyword                  => "end",
        :all_keyword                  => "all",
        :process_begin_format         => "%{indent}%{label?}%{postponed?}%{process_keyword}%{sensitivity?}%{begin?}",
        :process_end_format           => "%{indent}%{end_keyword} %{postponed?}%{process_keyword};",
        :label_format                 => "%{label}: ",
        :postponed_format             => "%{postponed_keyword} ",
        :postponed_keyword            => "postponed",
        :statement_begin_format       => "%{indent}%{begin_keyword}",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line  = []
        indent                 = directive.fetch(:indent   , "")
        label_format           = directive.fetch(:label_format          , WRITE_DIRECTIVE[:label_format          ])
        process_begin_format   = directive.fetch(:process_begin_format  , WRITE_DIRECTIVE[:process_begin_format  ])
        process_end_format     = directive.fetch(:process_end_format    , WRITE_DIRECTIVE[:process_end_format    ])
        statement_begin_format = directive.fetch(:statement_begin_format, WRITE_DIRECTIVE[:statement_begin_format])
        statement_indent       = directive.fetch(:statement_indent      , WRITE_DIRECTIVE[:statement_indent      ])
        process_keyword        = directive.fetch(:process_keyword       , WRITE_DIRECTIVE[:keyword               ])
        is_keyword             = directive.fetch(:is_keyword            , WRITE_DIRECTIVE[:is_keyword            ])
        all_keyword            = directive.fetch(:all_keyword           , WRITE_DIRECTIVE[:all_keyword           ])
        begin_keyword          = directive.fetch(:begin_keyword         , WRITE_DIRECTIVE[:begin_keyword         ])
        end_keyword            = directive.fetch(:end_keyword           , WRITE_DIRECTIVE[:end_keyword           ])
        postponed_format       = directive.fetch(:postponed_format      , WRITE_DIRECTIVE[:postponed_format      ])
        postponed_keyword      = directive.fetch(:postponed_keyword     , WRITE_DIRECTIVE[:postponed_keyword     ])
      
        begin_label = (@_label.nil?    )? "" : label_format     % {:label => @_label._write_string}
        end_label   = (@_label.nil?    )? "" :                               @_label._write_string
        postponed   = (@_postponed.nil?)? "" : postponed_format % {:postponed_keyword => postponed_keyword}
        if    @_sensitivity_all == true then
          sensitivity = " #{all_keyword}"
        elsif @_sensitivity_list.size == 0 then
          sensitivity = ""
        else
          sensitivity = "(" + @_sensitivity_list.map{|name| name._write_string}.join(', ') + ")"
        end

        if (@_declarative_item_list.size > 0)
          write_line.push   process_begin_format     % {
            :indent          => indent,
            :label?          => begin_label,
            :postponed?      => postponed,
            :process_keyword => process_keyword,
            :sensitivity?    => sensitivity,
            :is_keyword      => is_keyword,
            :begin?          => ""
          }
          write_line.concat _write_declarative_item_list(directive)
          write_line.push   statement_begin_format % {
            :indent          => indent,
            :begin_keyword   => begin_keyword
          }
        else
          write_line.push   process_begin_format     % {
            :indent          => indent,
            :label?          => begin_label,
            :postponed?      => postponed,
            :process_keyword => process_keyword,
            :sensitivity?    => sensitivity,
            :is_keyword      => is_keyword,
            :begin?          => " #{begin_keyword}"
          }
        end
        write_line.concat _write_statement_list(directive)
        write_line.push   process_end_format       % {
          :indent          => indent,
          :label?          => end_label,
          :postponed?      => postponed,
          :process_keyword => process_keyword,
          :end_keyword     => end_keyword
        }
      end
    end

  end
end
