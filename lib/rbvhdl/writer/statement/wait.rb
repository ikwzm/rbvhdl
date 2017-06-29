module RbVHDL::Ast

  module Statement

    class Wait
      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{keyword}%{on?}%{until?}%{for?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :on_format            => " %{_on_} %{name_list}",
        :until_format         => " %{_until_} %{condition}",
        :condition_format     => "%{expression}",
        :for_format           => " %{_for_} %{time}",
        :time_format          => "%{expression}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format   ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        label   = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        keyword = keyword_format % {:keyword => reserved_words[:wait]}

        if @_signal_list.size > 0 then
          on_format    = directive.fetch(:on_format , WRITE_DIRECTIVE[:on_format ])
          name_list    = @_signal_list.map{|signal| signal._write_string}.join(', ')
          on_string    = on_format    % {:_on_       => reserved_words[:on],
                                         :name_list  => name_list
          }
        else
          on_string    = ""
        end

        unless @_condition.nil? then
          until_format = directive.fetch(:until_format    , WRITE_DIRECTIVE[:until_format    ])
          cond_format  = directive.fetch(:condition_format, WRITE_DIRECTIVE[:condition_format])
          cond_string  = cond_format  % {:expression => @_condition._write_string}
          until_string = until_format % {:_until_    => reserved_words[:until],
                                         :condition  => cond_string,
          }
        else
          until_string = ""
        end
          
        unless @_expression.nil? then
          for_format   = directive.fetch(:for_format    , WRITE_DIRECTIVE[:for_format    ])
          time_format  = directive.fetch(:time_format   , WRITE_DIRECTIVE[:time_format   ])
          time_string  = time_format  % {:expression => @_expression._write_string}
          for_string   = for_format   % {:_for_      => reserved_words[:for],
                                         :time       => time_string
          }
        else
          for_string  = ""
        end
        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :on? => on_string, :until? => until_string, :for? => for_string} ]
      end
    end

  end
end
