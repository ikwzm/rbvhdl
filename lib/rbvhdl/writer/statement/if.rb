module RbVHDL::Ast

  module Statement

    class If
      WRITE_DIRECTIVE = {
        :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
        :label_format       => "%{label}: ",
        :if_begin_format    => "%{indent}%{label?}%{_if_} %{condition} %{_then_}",
        :elsif_begin_format => "%{indent}%{_elsif_} %{condition}%{_then_}",
        :else_begin_format  => "%{indent}%{_else_}",
        :if_end_format      => "%{indent}%{_end_} %{_if_};",
        :condition_format   => "%{expression}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line         = []
        indent             = directive.fetch(:indent           , "" )
        if_begin_format    = directive.fetch(:if_begin_format  , WRITE_DIRECTIVE[:if_begin_format  ])
        label_format       = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        if_end_format      = directive.fetch(:if_end_format    , WRITE_DIRECTIVE[:if_end_format    ])
        condition_format   = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        reserved_words     = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        condition   = condition_format % {expression: @_condition._write_string}
        begin_label = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label   = (@_label.nil?)? "" : @_label._write_string

        elsif_count = @_else_list.count{|_else| _else.class == RbVHDL::Ast::Statement::Elsif}
          
        write_line.push if_begin_format % {
          :indent    => indent,
          :label?    => begin_label,
          :_if_      => (elsif_count > 0)? "#{reserved_words[:if]}   " : reserved_words[:if],
          :condition => condition,
          :_then_    => reserved_words[:then],
        }

        statement_directive = directive.dup
        target_field_max_size_list = [self._target_field_max_size]
        target_field_max_size_list.concat @_else_list.map{|_else| _else._target_field_max_size}
        target_field_size = target_field_max_size_list.max
        if target_field_size > 0 then
          statement_directive[:target_format] = "%<target>-#{target_field_size+1}s"
        else
          statement_directive.delete(:target_format)
        end

        write_line.concat _write_statement_list(statement_directive)

        @_else_list.each do |_else|
          write_line.concat _else._write_line(statement_directive)
        end

        write_line.push if_end_format   % {
          :indent    => indent,
          :_end_     => reserved_words[:end],
          :_if_      => reserved_words[:if],
          :label?    => end_label,
        }
        return write_line
      end
    end

    class Elsif
      WRITE_DIRECTIVE = {
        :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
        :elsif_begin_format => "%{indent}%{_elsif_} %{condition} %{_then_}",
        :condition_format   => "%{expression}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line         = []
        indent             = directive.fetch(:indent, "" )
        elsif_begin_format = directive.fetch(:elsif_begin_format, WRITE_DIRECTIVE[:elsif_begin_format])
        elsif_keyword      = directive.fetch(:elsif_keyword     , WRITE_DIRECTIVE[:elsif_keyword     ])
        then_keyword       = directive.fetch(:then_keyword      , WRITE_DIRECTIVE[:then_keyword      ])
        condition_format   = directive.fetch(:condition_format  , WRITE_DIRECTIVE[:condition_format  ])
        reserved_words     = directive.fetch(:reserved_words    , WRITE_DIRECTIVE[:reserved_words    ])

        condition = condition_format % {expression: @_condition._write_string}
          
        write_line.push   elsif_begin_format % {
          :indent    => indent,
          :_elsif_   => reserved_words[:elsif],
          :condition => condition,
          :_then_    => reserved_words[:then],
        }

        write_line.concat _write_statement_list(directive)

        return write_line
      end
    end
    
    class Else
      WRITE_DIRECTIVE = {
        :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
        :else_begin_format  => "%{indent}%{_else_}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line         = []
        indent             = directive.fetch(:indent, "" )
        else_begin_format  = directive.fetch(:else_begin_format , WRITE_DIRECTIVE[:else_begin_format])
        reserved_words     = directive.fetch(:reserved_words    , WRITE_DIRECTIVE[:reserved_words   ])

        write_line.push else_begin_format % {
          :indent    => indent,
          :_else_    => reserved_words[:else],
        }

        write_line.concat _write_statement_list(directive)

        return write_line
      end
    end
  end
end
