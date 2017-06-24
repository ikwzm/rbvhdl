module RbVHDL::Ast

  module Statement

    class If
      WRITE_DIRECTIVE = {
        :if_keyword         => "if",
        :elsif_keyword      => "elsif",
        :else_keyword       => "else",
        :then_keyword       => "then",
        :end_keyword        => "end" ,
        :label_format       => "%{label}: ",
        :if_begin_format    => "%{indent}%{label?}%{if_keyword} %{condition} %{then_keyword}",
        :elsif_begin_format => "%{indent}%{elsif_keyword} %{condition}%{then_keyword}",
        :else_begin_format  => "%{indent}%{else_keyword}",
        :if_end_format      => "%{indent}%{end_keyword} %{if_keyword};",
        :condition_format   => "%{expression}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line         = []
        indent             = directive.fetch(:indent, "" )
        if_begin_format    = directive.fetch(:if_begin_format  , WRITE_DIRECTIVE[:if_begin_format  ])
        label_format       = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        if_end_format      = directive.fetch(:if_end_format    , WRITE_DIRECTIVE[:if_end_format    ])
        condition_format   = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        if_keyword         = directive.fetch(:if_keyword       , WRITE_DIRECTIVE[:if_keyword       ])
        then_keyword       = directive.fetch(:then_keyword     , WRITE_DIRECTIVE[:then_keyword     ])
        end_keyword        = directive.fetch(:end_keyword      , WRITE_DIRECTIVE[:end_keyword      ])

        condition   = condition_format % {expression: @_condition._write_string}
        begin_label = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label   = (@_label.nil?)? "" : @_label._write_string

        elsif_count = @_else_list.count{|_else| _else.class == RbVHDL::Ast::Statement::Elsif}
          
        write_line.push if_begin_format % {
          :indent       => indent,
          :label?       => begin_label,
          :if_keyword   => (elsif_count > 0)? "#{if_keyword}   " : if_keyword,
          :condition    => condition,
          :then_keyword => then_keyword,
        }

        write_line.concat(_write_statement_list(directive))

        @_else_list.each do |_else|
          write_line.concat(_else._write_line(directive))
        end

        write_line.push if_end_format   % {
          :indent       => indent,
          :if_keyword   => if_keyword,
          :label?       => end_label,
          :end_keyword  => end_keyword
        }
        return write_line
      end
    end

    class Elsif
      WRITE_DIRECTIVE = {
        :elsif_keyword      => "elsif",
        :then_keyword       => "then",
        :elsif_begin_format => "%{indent}%{elsif_keyword} %{condition} %{then_keyword}",
        :condition_format   => "%{expression}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line         = []
        indent             = directive.fetch(:indent, "" )
        elsif_begin_format = directive.fetch(:elsif_begin_format, WRITE_DIRECTIVE[:elsif_begin_format])
        elsif_keyword      = directive.fetch(:elsif_keyword     , WRITE_DIRECTIVE[:elsif_keyword     ])
        then_keyword       = directive.fetch(:then_keyword      , WRITE_DIRECTIVE[:then_keyword      ])
        condition_format   = directive.fetch(:condition_format  , WRITE_DIRECTIVE[:condition_format  ])

        condition = condition_format % {expression: @_condition._write_string}
          
        write_line.push elsif_begin_format % {
          :indent          => indent,
          :elsif_keyword   => elsif_keyword,
          :condition       => condition,
          :then_keyword    => then_keyword,
        }

        write_line.concat(_write_statement_list(directive))

        return write_line
      end
    end
    
    class Else
      WRITE_DIRECTIVE = {
        :else_keyword       => "else",
        :else_begin_format  => "%{indent}%{else_keyword}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line         = []
        indent             = directive.fetch(:indent, "" )
        else_begin_format  = directive.fetch(:else_begin_format , WRITE_DIRECTIVE[:else_begin_format])
        else_keyword       = directive.fetch(:else_keyword      , WRITE_DIRECTIVE[:else_keyword     ])

        write_line.push else_begin_format % {
          :indent       => indent,
          :else_keyword => else_keyword,
        }

        write_line.concat(_write_statement_list(directive))

        return write_line
      end
    end
  end
end
