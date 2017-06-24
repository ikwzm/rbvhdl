require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Statement

    class Loop

      WRITE_DIRECTIVE = {
        :loop_keyword       => "loop",
        :end_keyword        => "end" ,
        :label_format       => "%{label}: ",
        :loop_begin_format  => "%{indent}%{label?}%{loop_keyword}",
        :loop_end_format    => "%{indent}%{end_keyword} %{loop_keyword};",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        loop_begin_format = directive.fetch(:loop_begin_format, WRITE_DIRECTIVE[:loop_begin_format])
        loop_end_format   = directive.fetch(:loop_end_format  , WRITE_DIRECTIVE[:loop_end_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        loop_keyword      = directive.fetch(:loop_keyword     , WRITE_DIRECTIVE[:loop_keyword     ])
        end_keyword       = directive.fetch(:end_keyword      , WRITE_DIRECTIVE[:end_keyword      ])
        begin_label       = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label         = (@_label.nil?)? "" : @_label._write_string
        write_line.push(loop_begin_format % {:indent => indent, :loop_keyword => loop_keyword, :label? => begin_label})
        write_line.concat(_write_statement_list(directive))
        write_line.push(loop_end_format   % {:indent => indent, :loop_keyword => loop_keyword, :label? => end_label, :end_keyword => end_keyword})
        return write_line
      end
    end

    class WhileLoop

      WRITE_DIRECTIVE = {
        :while_keyword      => "while",
        :loop_keyword       => "loop",
        :end_keyword        => "end" ,
        :label_format       => "%{label}: ",
        :loop_begin_format  => "%{indent}%{label?}%{while_keyword} %{condition} %{loop_keyword}",
        :loop_end_format    => "%{indent}%{end_keyword} %{loop_keyword};",
        :condition_format   => "%{expression}",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        loop_begin_format = directive.fetch(:loop_begin_format, WRITE_DIRECTIVE[:loop_begin_format])
        loop_end_format   = directive.fetch(:loop_end_format  , WRITE_DIRECTIVE[:loop_end_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        while_keyword     = directive.fetch(:while_keyword    , WRITE_DIRECTIVE[:while_keyword    ])
        loop_keyword      = directive.fetch(:loop_keyword     , WRITE_DIRECTIVE[:loop_keyword     ])
        end_keyword       = directive.fetch(:end_keyword      , WRITE_DIRECTIVE[:end_keyword      ])
        begin_label       = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label         = (@_label.nil?)? "" : @_label._write_string
        condition         = condition_format % {expression: @_condition._write_string}
        write_line.push(loop_begin_format % {:indent        => indent,
                                             :loop_keyword  => loop_keyword,
                                             :label?        => begin_label,
                                             :while_keyword => while_keyword,
                                             :condition     => condition})
        write_line.concat(_write_statement_list(directive))
        write_line.push(loop_end_format   % {:indent        =>indent,
                                             :loop_keyword  => loop_keyword,
                                             :label?        => end_label,
                                             :end_keyword   => end_keyword})
        return write_line
      end
    end

    class ForLoop

      WRITE_DIRECTIVE = {
        :for_keyword        => "for",
        :in_keyword         => "in",
        :loop_keyword       => "loop",
        :end_keyword        => "end" ,
        :label_format       => "%{label}: ",
        :loop_begin_format  => "%{indent}%{label?}%{for_keyword} %{identifier} %{in_keyword} %{range} %{loop_keyword}",
        :loop_end_format    => "%{indent}%{end_keyword} %{loop_keyword};",
      }.merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )
      include  RbVHDL::Writer::Statement::WriteStatementList

      def _write_line(directive={})
        write_line = []
        indent            = directive.fetch(:indent   , "")
        loop_begin_format = directive.fetch(:loop_begin_format, WRITE_DIRECTIVE[:loop_begin_format])
        loop_end_format   = directive.fetch(:loop_end_format  , WRITE_DIRECTIVE[:loop_end_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format ])
        for_keyword       = directive.fetch(:for_keyword      , WRITE_DIRECTIVE[:for_keyword      ])
        in_keyword        = directive.fetch(:in_keyword       , WRITE_DIRECTIVE[:in_keyword       ])
        loop_keyword      = directive.fetch(:loop_keyword     , WRITE_DIRECTIVE[:loop_keyword     ])
        end_keyword       = directive.fetch(:end_keyword      , WRITE_DIRECTIVE[:end_keyword      ])
        begin_label       = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        end_label         = (@_label.nil?)? "" : @_label._write_string
        
        write_line.push(loop_begin_format % {:indent        => indent,
                                             :loop_keyword  => loop_keyword,
                                             :label?        => begin_label,
                                             :for_keyword   => for_keyword,
                                             :identifier    => @_index_identifier._write_string,
                                             :in_keyword    => in_keyword,
                                             :range         => @_index_range._write_string})
        write_line.concat(_write_statement_list(directive))
        write_line.push(loop_end_format   % {:indent        =>indent,
                                             :loop_keyword  => loop_keyword,
                                             :label?        => end_label,
                                             :end_keyword   => end_keyword})
        return write_line
      end
    end

    class Next

      WRITE_DIRECTIVE = {
        :keyword              => "next",
        :format               => "%{indent}%{label?}%{keyword}%{next_label?}%{condition?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :next_label_format    => " %{label}",
        :when_keyword         => "when",
        :condition_format     => " %{when_keyword} %{expression}"
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        next_keyword      = directive.fetch(:next_keyword     , WRITE_DIRECTIVE[:keyword           ])
        when_keyword      = directive.fetch(:when_keyword     , WRITE_DIRECTIVE[:when_keyword      ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])
        next_label_format = directive.fetch(:next_label_format, WRITE_DIRECTIVE[:next_label_format ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format  ])

        keyword    = keyword_format    % {:keyword    => next_keyword}
        label      = (@_label     .nil?)? "" : label_format      % {:label => @_label     ._write_string}
        next_label = (@_next_label.nil?)? "" : next_label_format % {:label => @_next_label._write_string}
        condition  = (@_condition .nil?)? "" : condition_format  % {:when_keyword => when_keyword, :expression => @_condition._write_string}

        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :next_label? => next_label, :condition? => condition} ]
      end
    end

    class Exit

      WRITE_DIRECTIVE = {
        :keyword              => "exit",
        :format               => "%{indent}%{label?}%{keyword}%{exit_label?}%{condition?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :exit_label_format    => " %{label}",
        :when_keyword         => "when",
        :condition_format     => " %{when_keyword} %{expression}"
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        exit_keyword      = directive.fetch(:exit_keyword     , WRITE_DIRECTIVE[:keyword           ])
        when_keyword      = directive.fetch(:when_keyword     , WRITE_DIRECTIVE[:when_keyword      ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])
        exit_label_format = directive.fetch(:exit_label_format, WRITE_DIRECTIVE[:exit_label_format ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format  ])

        keyword    = keyword_format    % {:keyword    => exit_keyword}
        label      = (@_label     .nil?)? "" : label_format      % {:label => @_label     ._write_string}
        exit_label = (@_exit_label.nil?)? "" : exit_label_format % {:label => @_exit_label._write_string}
        condition  = (@_condition .nil?)? "" : condition_format  % {:when_keyword => when_keyword, :expression => @_condition._write_string}

        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :exit_label? => exit_label, :condition? => condition} ]
      end
    end

  end
end

    
    
    
    
