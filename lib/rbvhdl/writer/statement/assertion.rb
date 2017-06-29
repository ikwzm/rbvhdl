module RbVHDL::Ast

  module Statement

    class Assertion
      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{keyword} %{condition}%{report?}%{severity?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :condition_format     => "%{expression}",
        :report_format        => " %{_report_} %{expression}",
        :severity_format      => " %{_severity_} %{expression}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])
        report_format     = directive.fetch(:report_format    , WRITE_DIRECTIVE[:report_format     ])
        severity_format   = directive.fetch(:severity_format  , WRITE_DIRECTIVE[:severity_format   ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words    ])

        keyword   = keyword_format   % {:keyword    => reserved_words[:assert]}
        condition = condition_format % {:expression => @_condition._write_string}
        label     = (@_label   .nil?)? "" : label_format    % {:label => @_label._write_string}
        report    = (@_report  .nil?)? "" : report_format   % {:_report_   => reserved_words[:report  ], :expression => @_report._write_string  }
        severity  = (@_severity.nil?)? "" : severity_format % {:_severity_ => reserved_words[:severity], :expression => @_severity._write_string}

        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :condition => condition, :report? => report, :severity? => severity} ]
      end
    end
    
  end
end
