module RbVHDL::Ast

  module Statement

    class Wait
      WRITE_DIRECTIVE = {
        :keyword              => "wait",
        :on_keyword           => "on",
        :until_keyword        => "until",
        :for_keyword          => "for",
        :format               => "%{indent}%{label?}%{keyword}%{on?}%{until?}%{for?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :on_format            => " %{on_keyword} %{name_list}",
        :until_format         => " %{until_keyword} %{condition}",
        :condition_format     => "%{expression}",
        :for_format           => " %{for_keyword} %{time}",
        :time_format          => "%{expression}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        wait_keyword      = directive.fetch(:wait_keyword     , WRITE_DIRECTIVE[:keyword           ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])

        label   = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}
        keyword = keyword_format % {:keyword => wait_keyword}

        if @_signal_list.size > 0 then
          on_keyword = directive.fetch(:on_keyword, WRITE_DIRECTIVE[:on_keyword])
          on_format  = directive.fetch(:on_format , WRITE_DIRECTIVE[:on_format ])
          on_string  = on_format % {:on_keyword => on_keyword, :name_list => @_signal_list.map{|signal| signal._write_string}.join(', ')}
        else
          on_string  = ""
        end

        unless @_condition.nil? then
          until_keyword    = directive.fetch(:until_keyword   , WRITE_DIRECTIVE[:until_keyword   ])
          until_format     = directive.fetch(:until_format    , WRITE_DIRECTIVE[:until_format    ])
          condition_format = directive.fetch(:condition_format, WRITE_DIRECTIVE[:condition_format])
          condition_string = condition_format % {:expression    => @_condition._write_string}
          until_string     = until_format     % {:until_keyword => until_keyword, :condition => condition_string}
        else
          until_string     = ""
        end
          
        unless @_expression.nil? then
          for_keyword = directive.fetch(:for_keyword   , WRITE_DIRECTIVE[:for_keyword   ])
          for_format  = directive.fetch(:for_format    , WRITE_DIRECTIVE[:for_format    ])
          time_format = directive.fetch(:time_format   , WRITE_DIRECTIVE[:time_format   ])
          time_string = time_format % {:expression  => @_expression._write_string}
          for_string  = for_format  % {:for_keyword => for_keyword, :time => time_string}
        else
          for_string  = ""
        end
        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :on? => on_string, :until? => until_string, :for? => for_string} ]
      end
    end

  end
end
