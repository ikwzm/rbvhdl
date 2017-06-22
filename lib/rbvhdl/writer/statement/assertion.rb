module RbVHDL::Ast

  module Statement

    class Assertion
      WRITE_DIRECTIVE = {
        :keyword              => "assert",
        :format               => "%{indent}%{label}%{keyword} %{condition}%{report}%{severity};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :condition_format     => "%{expression}",
        :report_format        => " %{report_keyword} %{expression}",
        :report_keyword       => "report",
        :severity_format      => " %{severity_keyword} %{expression}",
        :severity_keyword     => "severity",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        assert_keyword    = directive.fetch(:assert_keyword   , WRITE_DIRECTIVE[:keyword           ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        condition_format  = directive.fetch(:condition_format , WRITE_DIRECTIVE[:condition_format  ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])
        report_format     = directive.fetch(:report_format    , WRITE_DIRECTIVE[:report_format     ])
        report_keyword    = directive.fetch(:report_keyword   , WRITE_DIRECTIVE[:report_keyword    ])
        severity_format   = directive.fetch(:severity_format  , WRITE_DIRECTIVE[:severity_format   ])
        severity_keyword  = directive.fetch(:severity_keyword , WRITE_DIRECTIVE[:severity_keyword  ])

        keyword   = keyword_format   % {:keyword    => assert_keyword}
        condition = condition_format % {:expression => @_condition._write_string}
        label     = (@_label   .nil?)? "" : label_format    % {:label => @_label._write_string}
        report    = (@_report  .nil?)? "" : report_format   % {:report_keyword   => report_keyword  , :expression => @_report._write_string  }
        severity  = (@_severity.nil?)? "" : severity_format % {:severity_keyword => severity_keyword, :expression => @_severity._write_string}

        return [ format % {indent: indent, label: label, keyword: keyword, condition: condition, report: report, severity: severity} ]
      end
    end
    
  end
end
