module RbVHDL::Ast

  class LibraryClause
    WRITE_DIRECTIVE = {
      :reserved_words => RbVHDL::Writer::RESERVED_WORDS,
      :format         => "%{indent}%<_library_>-7s %{identifier_list};",
      :separator      => ", "
    }

    def _write_line(directive={})
      indent          = directive.fetch(:indent   , "")

      reserved_words  = directive.fetch(:reserved_words, WRITE_DIRECTIVE[:reserved_words])
      format          = directive.fetch(:format        , WRITE_DIRECTIVE[:format        ])
      separator       = directive.fetch(:separator     , WRITE_DIRECTIVE[:separator     ])

      identifier_list = @_identifier_list.map{|identifier| identifier._write_string}.join(separator)
      
      return [ format % {:indent => indent, :_library_ => reserved_words[:library], :identifier_list => identifier_list} ]
    end
  end

end
