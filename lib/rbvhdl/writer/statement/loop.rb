require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Statement

    class Loop

      WRITE_DIRECTIVE = {
        :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
        :label_format       => "%{label}: ",
        :loop_begin_format  => "%{indent}%{label?}%{_loop_}",
        :loop_end_format    => "%{indent}%{_end_} %{_loop_};",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        loop_begin_format = directive.fetch(:loop_begin_format, WRITE_DIRECTIVE[:loop_begin_format])
        loop_end_format   = directive.fetch(:loop_end_format  , WRITE_DIRECTIVE[:loop_end_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])
        
        begin_label       = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label         = (@_label.nil?)? "" : @_label._write_string

        write_line.push   loop_begin_format % {
          :indent     => indent,
          :label?     => begin_label,
          :_loop_     => reserved_words[:loop],
        }
        write_line.concat _write_statement_list(directive)
        write_line.push   loop_end_format   % {
          :indent     => indent,
          :_end_      => reserved_words[:end],
          :_loop_     => reserved_words[:loop],
          :label?     => end_label,
        }
        return write_line
      end
    end

    class WhileLoop

      WRITE_DIRECTIVE = {
        :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
        :label_format       => "%{label}: ",
        :loop_begin_format  => "%{indent}%{label?}%{_while_} %{condition} %{_loop_}",
        :loop_end_format    => "%{indent}%{_end_} %{_loop_};",
        :condition_format   => "%{expression}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        loop_begin_format = directive.fetch(:loop_begin_format, WRITE_DIRECTIVE[:loop_begin_format])
        loop_end_format   = directive.fetch(:loop_end_format  , WRITE_DIRECTIVE[:loop_end_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        begin_label       = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label         = (@_label.nil?)? "" : @_label._write_string
        condition         = condition_format % {expression: @_condition._write_string}

        write_line.push   loop_begin_format % {
          :indent     => indent,
          :label?     => begin_label,
          :_while_    => reserved_words[:while],
          :condition  => condition,
          :_loop_     => reserved_words[:loop],
        }
        write_line.concat _write_statement_list(directive)
        write_line.push   loop_end_format   % {
          :indent     => indent,
          :_end_      => reserved_words[:end],
          :_loop_     => reserved_words[:loop],
          :label?     => end_label,
        }
        return write_line
      end
    end

    class ForLoop

      WRITE_DIRECTIVE = {
        :reserved_words     => RbVHDL::Writer::RESERVED_WORDS,
        :label_format       => "%{label}: ",
        :loop_begin_format  => "%{indent}%{label?}%{_for_} %{identifier} %{_in_} %{range} %{_loop_}",
        :loop_end_format    => "%{indent}%{_end_} %{_loop_};",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        loop_begin_format = directive.fetch(:loop_begin_format, WRITE_DIRECTIVE[:loop_begin_format])
        loop_end_format   = directive.fetch(:loop_end_format  , WRITE_DIRECTIVE[:loop_end_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        begin_label       = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label         = (@_label.nil?)? "" : @_label._write_string
        
        write_line.push   loop_begin_format % {
          :indent     => indent,
          :label?     => begin_label,
          :_for_      => reserved_words[:for],
          :identifier => @_index_identifier._write_string,
          :_in_       => reserved_words[:in],
          :range      => @_index_range._write_string,
          :_loop_     => reserved_words[:loop],
        }
        write_line.concat _write_statement_list(directive)
        write_line.push   loop_end_format   % {
          :indent     => indent,
          :_end_      => reserved_words[:end],
          :_loop_     => reserved_words[:loop],
          :label?     => end_label,
        }
        return write_line
      end
    end

    class Next

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{keyword}%{next_label?}%{condition?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :next_label_format    => " %{label}",
        :condition_format     => " %{_when_} %{expression}"
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format   ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        next_label_format = directive.fetch(:next_label_format, WRITE_DIRECTIVE[:next_label_format])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        keyword    =                           keyword_format    % {:keyword    => reserved_words[:next]     }
        label      = (@_label     .nil?)? "" : label_format      % {:label      => @_label     ._write_string}
        next_label = (@_next_label.nil?)? "" : next_label_format % {:label      => @_next_label._write_string}
        condition  = (@_condition .nil?)? "" : condition_format  % {:_when_     => reserved_words[:when]     ,
                                                                    :expression => @_condition._write_string }

        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :next_label? => next_label, :condition? => condition} ]
      end
    end

    class Exit

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{keyword}%{exit_label?}%{condition?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :exit_label_format    => " %{label}",
        :condition_format     => " %{_when_} %{expression}"
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format   ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        exit_label_format = directive.fetch(:exit_label_format, WRITE_DIRECTIVE[:exit_label_format])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        keyword    =                           keyword_format    % {:keyword    => reserved_words[:exit]     }
        label      = (@_label     .nil?)? "" : label_format      % {:label      => @_label     ._write_string}
        exit_label = (@_exit_label.nil?)? "" : exit_label_format % {:label      => @_exit_label._write_string}
        condition  = (@_condition .nil?)? "" : condition_format  % {:_when_     => reserved_words[:when]     ,
                                                                    :expression => @_condition._write_string }

        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :exit_label? => exit_label, :condition? => condition} ]
      end
    end

  end
end

    
    
    
    
