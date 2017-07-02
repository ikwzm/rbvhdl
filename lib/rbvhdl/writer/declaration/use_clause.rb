module RbVHDL::Ast

  module Declaration

    class UseClause
      WRITE_DIRECTIVE = {
        :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
        :format         => "%{indent}%<_use_>-7s %{name_list};",
        :separator      => ", "
      }

      def _write_line(directive={})
        indent          = directive.fetch(:indent   , "")

        reserved_words  = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
        format          = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
        separator       = directive.fetch(:separator     , WRITE_DIRECTIVE[:separator     ])

        name_list       = @_name_list.map{|name| name._write_string({})}.join(separator)

        return [ format % {indent: indent, _use_: reserved_words[:use], name_list: name_list} ]
      end
    end

  end
end

