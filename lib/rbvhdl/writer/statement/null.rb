module RbVHDL::Ast

  module Statement

    class Null
      WRITE_DIRECTIVE = {
        :reserved_words       => RbVHDL::Writer::RESERVED_WORDS,
        :format               => "%{indent}%{label?}%{keyword};",
        :label_format         => "%{label}: ",
        :keyword_format       => "%{keyword}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        label_format      = directive.fetch(:label_format     , WRITE_DIRECTIVE[:label_format      ])
        reserved_words    = directive.fetch(:reserved_words   , WRITE_DIRECTIVE[:reserved_words    ])

        keyword = keyword_format % {:keyword => reserved_words[:null]}
        label   = (@_label.nil?)? "" : label_format % {:label => @_label._write_string}

        return [ format % {:indent => indent, :label? => label, :keyword => keyword} ]
      end
    end

  end
end
