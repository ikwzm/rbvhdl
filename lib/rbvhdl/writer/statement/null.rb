module RbVHDL::Ast

  module Statement

    class Null
      WRITE_DIRECTIVE = {
        :keyword              => "null",
        :format               => "%{indent}%{label}%{keyword};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        null_keyword      = directive.fetch(:null_keyword     , WRITE_DIRECTIVE[:keyword           ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])

        keyword = keyword_format % {:keyword => null_keyword}
        label   = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}

        return [ format % {indent: indent, label: label, keyword: keyword} ]
      end
    end

  end
end
