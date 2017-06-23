module RbVHDL::Ast

  module Statement

    class Return
      WRITE_DIRECTIVE = {
        :keyword              => "return",
        :format               => "%{indent}%{label?}%{keyword}%{expression?};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
        :expression_format    => " %{expression}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        return_keyword    = directive.fetch(:return_keyword   , WRITE_DIRECTIVE[:keyword           ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        expression_format = directive.fetch(:expression_format, WRITE_DIRECTIVE[:expression_format ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])

        keyword    = keyword_format    % {:keyword    => return_keyword}
        label      = (@_label.nil?     )? "" : label_format      % {:label      => @_label._write_string     }
        expression = (@_expression.nil?)? "" : expression_format % {:expression => @_expression._write_string}

        return [ format % {:indent => indent, :label? => label, keyword: keyword, :expression? => expression} ]
      end
    end

  end
end
