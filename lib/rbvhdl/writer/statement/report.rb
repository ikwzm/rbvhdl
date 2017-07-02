module RbVHDL::Ast

  module Statement

    class Report
      WRITE_DIRECTIVE = {
        :keyword              => "report",
        :format               => "%{indent}%{label?}%{keyword} %{expression}%{severity?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :expression_format    => "%{expression}",
        :severity_format      => " %{severity_keyword} %{expression}",
        :severity_keyword     => "severity",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        report_keyword    = directive.fetch(:report_keyword   , WRITE_DIRECTIVE[:keyword           ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        expression_format = directive.fetch(:expression_format, WRITE_DIRECTIVE[:expression_format ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])
        severity_format   = directive.fetch(:severity_format  , WRITE_DIRECTIVE[:severity_format   ])
        severity_keyword  = directive.fetch(:severity_keyword , WRITE_DIRECTIVE[:severity_keyword  ])

        keyword    = keyword_format    % {:keyword    => report_keyword}
        expression = expression_format % {:expression => @_expression._write_string}
        label     = (@_label   .nil?)? "" : label_format    % {:label => @_label._write_string}
        severity  = (@_severity.nil?)? "" : severity_format % {:severity_keyword => severity_keyword, :expression => @_severity._write_string}

        return [ format % {:indent => indent, :label? => label, :keyword => keyword, :expression => expression, :severity? => severity} ]
      end
    end

  end
end

