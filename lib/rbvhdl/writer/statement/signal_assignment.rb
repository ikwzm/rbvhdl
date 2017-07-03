module RbVHDL::Ast

  module Statement

    class SimpleSignalAssignment

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{postponed?}%{target}<=%{delay?}%{waveform};",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :postponed_format     => "%{_postponed_} ",
        :delay_format         => " %{delay}",
        :target_align_enable  => true,
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent, "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        target_format     = directive.fetch(:target_format    , WRITE_DIRECTIVE[:target_format    ])
        delay_format      = directive.fetch(:delay_format     , WRITE_DIRECTIVE[:delay_format     ])
        postponed_format  = directive.fetch(:postponed_format , WRITE_DIRECTIVE[:postponed_format ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])

        label     = (@_label    .nil?)? "" : label_format     % {:label       => @_label._write_string     }
        delay     = (@_delay    .nil?)? "" : delay_format     % {:delay       => @_delay._write_string     }
        postponed = (@_postponed.nil?)? "" : postponed_format % {:_postponed_ => reserved_words[:postponed]}
        target    = target_format % {:target => @_target._write_string}

        waveform_value_max_size = @_waveform._list.map{|pair| (pair[0].nil?)? 0 : pair[0]._write_string.size}.max
        waveform_after_max_size = @_waveform._list.map{|pair| (pair[1].nil?)? 0 : pair[1]._write_string.size}.max

        waveform_directive = directive.dup
        if waveform_after_max_size > 0 then
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s%{after?}"
          waveform_directive[:after_format   ] = " %<_after_>-5s %<time>#{waveform_after_max_size}s"
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
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{postponed?}%{target}<=%{delay?}%{waveform};",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :postponed_format     => "%{_postponed_} ",
        :delay_format         => " %{delay}",
        :waveform_format      => "%{waveform}%{when?}",
        :when_format          => " %{_when_} %{condition}",
        :target_align_enable  => true,
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format           ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format     ])
        target_format     = directive.fetch(:target_format    , WRITE_DIRECTIVE[:target_format    ])
        delay_format      = directive.fetch(:delay_format     , WRITE_DIRECTIVE[:delay_format     ])
        postponed_format  = directive.fetch(:postponed_format , WRITE_DIRECTIVE[:postponed_format ])
        waveform_format   = directive.fetch(:waveform_format  , WRITE_DIRECTIVE[:waveform_format  ])
        when_format       = directive.fetch(:when_format      , WRITE_DIRECTIVE[:when_format      ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])
        
        label     = (@_label    .nil?)? "" : label_format     % {:label       => @_label._write_string     }
        delay     = (@_delay    .nil?)? "" : delay_format     % {:delay       => @_delay._write_string     }
        postponed = (@_postponed.nil?)? "" : postponed_format % {:_postponed_ => reserved_words[:postponed]}
        target    = target_format % {:target => @_target._write_string}

        waveform_value_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[0].nil?)? 0 : pair[0]._write_string.size}.max}.max
        waveform_after_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[1].nil?)? 0 : pair[1]._write_string.size}.max}.max
        condition_max_size      = @_waveform_list.map{|pair|                          (pair[1].nil?)? 0 : pair[1]._write_string.size}.max

        waveform_directive = directive.dup
        if waveform_after_max_size > 0 then
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s%{after?}"
          waveform_directive[:after_format   ] = " %<_after_>-5s %<time>#{waveform_after_max_size}s"
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
        else_separator   = " #{reserved_words[:else]}\n#{else_indent}"

        waveform_string  = @_waveform_list.map{ |pair|
          waveform  = pair[0]
          condition = pair[1]
          if condition.nil? then
            when_string = ""
          else
            when_string = when_format % {:_when_    => reserved_words[:when],
                                         :condition => condition_format % {:expression => condition._write_string}}
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
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{postponed?}%{_with_} %{condition} %{_select_}\n%{assign}",
        :assign_format        => "%{indent}%{assign_indent}%{target}<=%{delay?}%{waveform};",
        :assign_indent        => "    ",
        :label_format         => "%{label}: ",
        :target_format        => "%{target} ",
        :postponed_format     => "%{_postponed_} ",
        :delay_format         => " %{delay}",
        :waveform_format      => "%{waveform}%{when?}",
        :when_format          => " %{_when_} %{condition}",
        :target_align_enable  => false,
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
        waveform_format   = directive.fetch(:waveform_format  , WRITE_DIRECTIVE[:waveform_format  ])
        when_format       = directive.fetch(:when_format      , WRITE_DIRECTIVE[:when_format      ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words   ])
        
        label     = (@_label    .nil?)? "" : label_format     % {:label       => @_label._write_string     }
        delay     = (@_delay    .nil?)? "" : delay_format     % {:delay       => @_delay._write_string     }
        postponed = (@_postponed.nil?)? "" : postponed_format % {:_postponed_ => reserved_words[:postponed]}
        target    = target_format % {:target => @_target._write_string}

        waveform_value_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[0].nil?)? 0 : pair[0]._write_string.size}.max}.max
        waveform_after_max_size = @_waveform_list.map{|pair| pair[0]._list.map{|pair| (pair[1].nil?)? 0 : pair[1]._write_string.size}.max}.max
        condition_max_size      = @_waveform_list.map{|pair|                          (pair[1].nil?)? 0 : pair[1]._write_string.size}.max

        waveform_directive = directive.dup
        if waveform_after_max_size > 0 then
          waveform_directive[:waveform_format] = " %<value>-#{waveform_value_max_size}s%{after?}"
          waveform_directive[:after_format   ] = " %<_after_>-5s %<time>#{waveform_after_max_size}s"
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
            when_string = when_format % {:_when_    => reserved_words[:when],
                                         :condition => condition_format % {:expression => condition._write_string}}
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
                  :_with_         => reserved_words[:with],
                  :condition      => @_expression._write_string,
                  :_select_       => reserved_words[:select],
                  :assign         => assign_string,
                }).split(/\n/)
      end
    end

    class Waveform
      WRITE_DIRECTIVE = {
        :reserved_words  => RbVHDL::Writer::RESERVED_WORDS,
        :waveform_format => "%{value}%{after?}",
        :after_format    => " %{_after_} %{time}",
      }
      def _write_line(directive={})
        waveform_format = directive.fetch(:waveform_format, WRITE_DIRECTIVE[:waveform_format])
        after_format    = directive.fetch(:after_format   , WRITE_DIRECTIVE[:after_format   ])
        reserved_words  = directive.fetch(:reserved_words , WRITE_DIRECTIVE[:reserved_words ])

        return @_list.map{|pair|
          value = pair[0]
          time  = pair[1]
          if time.nil? then
            after_string = after_format % {:_after_ => ""                    , :time => ""                }
          else
            after_string = after_format % {:_after_ => reserved_words[:after], :time => time._write_string}
          end
          waveform_format % {:value => value._write_string, :after? => after_string}
        }
      end
    end

    class Transport

      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
      }
      def _write_string(directive={})
        reserved_words  = directive.fetch(:reserved_words , WRITE_DIRECTIVE[:reserved_words ])
        return reserved_words[:transport]
      end

    end

    class Inertial
      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :inertial_format  => "%{reject?}%{_inertial_}",
        :reject_format    => "%{_reject_} %{expression} "
      }
      def _write_string(directive={})
        reserved_words  = directive.fetch(:reserved_words , WRITE_DIRECTIVE[:reserved_words  ])
        inertial_format = directive.fetch(:inertial_format, WRITE_DIRECTIVE[:inertial_format ])
        reject_format   = directive.fetch(:reject_format  , WRITE_DIRECTIVE[:reject_format   ])
        return inertial_format % {
          :_inertial_ => reserved_words[:inertial],
          :reject?    => (@_reject.nil?)? "" : reject_format % {:_reject_   => reserved_words[:reject],
                                                                :expression => @_reject._write_string },
        }
      end
    end

  end
end
