module RbVHDL::Ast

  module Statement

    class SimpleSignalAssignment

      WRITE_DIRECTIVE = {
        :format               => "%{indent}%{label?}%{postponed?}%{target}<=%{delay?}%{waveform};",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :postponed_format     => "%{postponed_keyword} ",
        :postponed_keyword    => "postponed",
        :delay_format         => " %{delay}",
        :target_align         => true,
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent, "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        target_format     = directive.fetch(:target_format    , WRITE_DIRECTIVE[:target_format    ])
        delay_format      = directive.fetch(:delay_format     , WRITE_DIRECTIVE[:delay_format     ])
        postponed_format  = directive.fetch(:postponed_format , WRITE_DIRECTIVE[:postponed_format ])
        postponed_keyword = directive.fetch(:postponed_keyword, WRITE_DIRECTIVE[:postponed_keyword])

        label     = (@_label    .nil?)? "" : label_format     % {:label => @_label._write_string}
        delay     = (@_delay    .nil?)? "" : delay_format     % {:delay => @_delay._write_string}
        postponed = (@_postponed.nil?)? "" : postponed_format % {:postponed_keyword => postponed_keyword}
        target    = target_format % {:target => @_target._write_string}

        waveform_value_max_size = @_waveform._list.map{|pair| (pair[0].nil?)? 0 : pair[0]._write_string.size}.max
        waveform_after_max_size = @_waveform._list.map{|pair| (pair[1].nil?)? 0 : pair[1]._write_string.size}.max

        waveform_directive = directive.dup
        if waveform_after_max_size > 0 then
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s%{after?}"
          waveform_directive[:after_format   ] = " %<after_keyword>-5s %<time>#{waveform_after_max_size}s"
        else
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s"
          waveform_directive[:after_format   ] = ""
        end

        waveform_indent_size = (format % {
                                  :indent     => indent,
                                  :label?     => label,
                                  :postponed? => postponed,
                                  :target     => target,
                                  :delay?     => delay,
                                  :waveform   => ""
                                }).size-1
        waveform_indent    = " " * waveform_indent_size
        waveform_separator = ",\n#{waveform_indent}"

        waveform_string    = @_waveform._write_line(waveform_directive).join(waveform_separator)
        
        return (format % {
                   :indent => indent,
                   :label? => label,
                   :postponed? => postponed,
                   :target     => target,
                   :delay?     => delay,
                   :waveform   => waveform_string
                }).split(/\n/)
      end
    end

    class ConditionalSignalAssignment

      WRITE_DIRECTIVE = {
        :format               => "%{indent}%{label?}%{postponed?}%{target}<=%{delay?}%{waveform};",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :postponed_format     => "%{postponed_keyword} ",
        :postponed_keyword    => "postponed",
        :delay_format         => " %{delay}",
        :when_keyword         => "when",
        :else_keyword         => "else",
        :waveform_format      => "%{waveform}%{when?}",
        :when_format          => " %{when_keyword} %{condition}",
        :target_align         => true,
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        target_format     = directive.fetch(:target_format    , WRITE_DIRECTIVE[:target_format    ])
        delay_format      = directive.fetch(:delay_format     , WRITE_DIRECTIVE[:delay_format     ])
        postponed_format  = directive.fetch(:postponed_format , WRITE_DIRECTIVE[:postponed_format ])
        postponed_keyword = directive.fetch(:postponed_keyword, WRITE_DIRECTIVE[:postponed_keyword])
        waveform_format   = directive.fetch(:waveform_format  , WRITE_DIRECTIVE[:waveform_format  ])
        when_format       = directive.fetch(:when_format      , WRITE_DIRECTIVE[:when_format      ])
        when_keyword      = directive.fetch(:when_keyword     , WRITE_DIRECTIVE[:when_keyword     ])
        else_keyword      = directive.fetch(:else_keyword     , WRITE_DIRECTIVE[:else_keyword     ])
        
        label     = (@_label    .nil?)? "" : label_format     % {:label => @_label._write_string}
        delay     = (@_delay    .nil?)? "" : delay_format     % {:delay => @_delay._write_string}
        postponed = (@_postponed.nil?)? "" : postponed_format % {:postponed_keyword => postponed_keyword}
        target    = target_format % {:target => @_target._write_string}

        waveform_value_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[0].nil?)? 0 : pair[0]._write_string.size}.max}.max
        waveform_after_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[1].nil?)? 0 : pair[1]._write_string.size}.max}.max
        condition_max_size      = @_waveform_list.map{|pair|                          (pair[1].nil?)? 0 : pair[1]._write_string.size}.max

        waveform_directive = directive.dup
        if waveform_after_max_size > 0 then
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s%{after?}"
          waveform_directive[:after_format   ] = " %<after_keyword>-5s %<time>#{waveform_after_max_size}s"
        else
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s"
          waveform_directive[:after_format   ] = ""
        end
        condition_format = "%<expression>-#{condition_max_size}s"
        
        waveform_indent_size = (format % {
                                  :indent     => indent,
                                  :label?     => label,
                                  :postponed? => postponed,
                                  :target     => target,
                                  :delay?     => delay,
                                  :waveform   => ""
                                }).size-1
        waveform_indent      = " " * waveform_indent_size
        waveform_separator   = ",\n#{waveform_indent}"

        else_indent_size     = (format % {
                                  :indent     => indent,
                                  :label?     => label,
                                  :postponed? => postponed,
                                  :target     => target,
                                  :delay?     => delay,
                                  :waveform   => waveform_format % {:waveform => "", :when? => ""}
                                }).size-1
        else_indent      = " " * else_indent_size
        else_separator   = " #{else_keyword}\n#{else_indent}"

        waveform_string  = @_waveform_list.map{ |pair|
          waveform  = pair[0]
          condition = pair[1]
          if condition.nil? then
            when_string = ""
          else
            when_string = when_format % {:when_keyword => when_keyword,
                                         :condition    => condition_format % {:expression => condition._write_string}}
          end
          waveform_string = waveform._write_line(waveform_directive).join(waveform_separator)
          waveform_format % {:waveform => waveform_string, :when? => when_string}
        }.join(else_separator)

        return (format % {
                  :indent     => indent,
                  :label?     => label,
                  :postponed? => postponed,
                  :target     => target,
                  :delay?     => delay,
                  :waveform   => waveform_string
                }).split(/\n/)
      end
      
    end

    class SelectedSignalAssignment
      WRITE_DIRECTIVE = {
        :format               => "%{indent}%{label?}%{postponed?}%{with_keyword} %{condition} %{select_keyword}\n%{assign}",
        :assign_format        => "%{indent}%{assign_indent}%{target}<=%{delay?}%{waveform};",
        :assign_indent        => "    ",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :postponed_format     => "%{postponed_keyword} ",
        :postponed_keyword    => "postponed",
        :delay_format         => " %{delay}",
        :when_keyword         => "when",
        :select_format        => "%{with_keyword} %{condition} %{select_keyword}\n",
        :with_keyword         => "with",
        :select_keyword       => "select",
        :else_keyword         => "else",
        :waveform_format      => "%{waveform}%{when?}",
        :when_format          => " %{when_keyword} %{condition}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        assign_format     = directive.fetch(:assign_format    , WRITE_DIRECTIVE[:assign_format    ])
        assign_indent     = directive.fetch(:assign_indent    , WRITE_DIRECTIVE[:assign_indent    ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        target_format     = directive.fetch(:target_format    , WRITE_DIRECTIVE[:target_format    ])
        delay_format      = directive.fetch(:delay_format     , WRITE_DIRECTIVE[:delay_format     ])
        postponed_format  = directive.fetch(:postponed_format , WRITE_DIRECTIVE[:postponed_format ])
        postponed_keyword = directive.fetch(:postponed_keyword, WRITE_DIRECTIVE[:postponed_keyword])
        waveform_format   = directive.fetch(:waveform_format  , WRITE_DIRECTIVE[:waveform_format  ])
        when_format       = directive.fetch(:when_format      , WRITE_DIRECTIVE[:when_format      ])
        when_keyword      = directive.fetch(:when_keyword     , WRITE_DIRECTIVE[:when_keyword     ])
        with_keyword      = directive.fetch(:with_keyword     , WRITE_DIRECTIVE[:with_keyword     ])
        select_keyword    = directive.fetch(:select_keyword   , WRITE_DIRECTIVE[:select_keyword   ])
        select_format     = directive.fetch(:select_format    , WRITE_DIRECTIVE[:select_format    ])
        
        label     = (@_label    .nil?)? "" : label_format     % {:label => @_label._write_string}
        delay     = (@_delay    .nil?)? "" : delay_format     % {:delay => @_delay._write_string}
        postponed = (@_postponed.nil?)? "" : postponed_format % {:postponed_keyword => postponed_keyword}
        target    = target_format % {:target => @_target._write_string}

        waveform_value_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[0].nil?)? 0 : pair[0]._write_string.size}.max}.max
        waveform_after_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[1].nil?)? 0 : pair[1]._write_string.size}.max}.max
        condition_max_size      = @_waveform_list.map{|pair|                          (pair[1].nil?)? 0 : pair[1]._write_string.size}.max

        waveform_directive = directive.dup
        if waveform_after_max_size > 0 then
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s%{after?}"
          waveform_directive[:after_format   ] = " %<after_keyword>-5s %<time>#{waveform_after_max_size}s"
        else
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s"
          waveform_directive[:after_format   ] = ""
        end
        # condition_format = "%<expression>-#{condition_max_size}s"
        condition_format = "%{expression}"
        
        waveform_indent_size = (assign_format % {
                                  :indent        => indent,
                                  :assign_indent => assign_indent,
                                  :target        => target,
                                  :delay?        => delay,
                                  :waveform      => ""
                                }).size-1
        waveform_indent      = " " * waveform_indent_size
        waveform_separator   = ",\n#{waveform_indent}"

        else_indent_size     = (assign_format % {
                                  :indent        => indent,
                                  :assign_indent => assign_indent,
                                  :target        => target,
                                  :delay?        => delay,
                                  :waveform      => waveform_format % {:waveform => "", :when? => ""}
                                }).size-1
        else_indent      = " " * else_indent_size
        else_separator   = ",\n#{else_indent}"

        waveform_string  = @_waveform_list.map{ |pair|
          waveform  = pair[0]
          condition = pair[1]
          if condition.nil? then
            when_string = ""
          else
            when_string = when_format % {:when_keyword => when_keyword,
                                         :condition    => condition_format % {:expression => condition._write_string}}
          end
          waveform_string = waveform._write_line(waveform_directive).join(waveform_separator)
          waveform_format % {:waveform => waveform_string, :when? => when_string}
        }.join(else_separator)

        assign_string = assign_format % {
          :indent        => indent,
          :assign_indent => assign_indent,
          :target        => target,
          :delay?        => delay,
          :waveform      => waveform_string
        }

        return (format % {
                  :indent         => indent,
                  :label?         => label,
                  :postponed?     => postponed,
                  :with_keyword   => with_keyword,
                  :condition      => @_expression._write_string,
                  :select_keyword => select_keyword, 
                  :assign         => assign_string,
                }).split(/\n/)
      end
    end

    class Waveform
      WRITE_DIRECTIVE = {
        :waveform_format => "%{value}%{after?}",
        :after_format    => " %{after_keyword} %{time}",
        :after_keyword   => "after",
      }
      def _write_line(directive={})
        waveform_format = directive.fetch(:waveform_format, WRITE_DIRECTIVE[:waveform_format])
        after_format    = directive.fetch(:after_format   , WRITE_DIRECTIVE[:after_format   ])
        after_keyword   = directive.fetch(:after_keyword  , WRITE_DIRECTIVE[:after_keyword  ])
        return @_list.map{|pair|
          value = pair[0]
          time  = pair[1]
          if time.nil? then
            after_string = after_format % {:after_keyword => ""           , :time => ""                }
          else
            after_string = after_format % {:after_keyword => after_keyword, :time => time._write_string}
          end
          waveform_format % {:value => value._write_string, :after? => after_string}
        }
      end
    end

    class Transport

      WRITE_DIRECTIVE = {
        :transport_keyword    => "transport",
      }
      def _write_string(directive={})
        return directive.fetch(:transport_keyword , WRITE_DIRECTIVE[:transport_keyword])
      end

    end

    class Inertial
      WRITE_DIRECTIVE = {
        :inertial_keyword => "inertial",
        :inertial_format  => "%{inertial_keyword}%{reject?}",
        :reject_keyword   => "reject",
        :reject_format    => " %{reject_keyword} %{expression}"
      }
      def _write_string(directive={})
        inertial_keyword = directive.fetch(:inertial_keyword, WRITE_DIRECTIVE[:inertial_keyword])
        inertial_format  = directive.fetch(:inertial_format , WRITE_DIRECTIVE[:inertial_format ])
        reject_keyword   = directive.fetch(:reject_keyword  , WRITE_DIRECTIVE[:reject_keyword  ])
        reject_format    = directive.fetch(:reject_format   , WRITE_DIRECTIVE[:reject_format   ])
        return inertial_format % {
          :inertial_keyword => inertial_keyword,
          :reject?          => (@_reject.nil?)? "" : reject_format % {:reject_keyword => reject_keyword,
                                                                      :expression     => @_reject._write_string}
        }
      end
    end

  end
end
