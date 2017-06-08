module RbVHDL::Ast

  class LibraryClause
    WRITE_DIRECTIVE = {:keyword => "library", :format => "%{indent}%<keyword>-7s %{identifier_list};", :separator => ", "}

    def _write_line(directive={})
      indent    = directive.fetch(:indent   , "")
      format    = directive.fetch(:format   , WRITE_DIRECTIVE[:format   ])
      keyword   = directive.fetch(:keyword  , WRITE_DIRECTIVE[:keyword  ])
      separator = directive.fetch(:separator, WRITE_DIRECTIVE[:separator])
      identifier_list = @_identifier_list.map{|identifier| identifier._write_string}.join(separator)
      return [ format % {indent: indent, keyword: keyword, identifier_list: identifier_list} ]
    end
  end

end
