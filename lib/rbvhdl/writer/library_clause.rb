module RbVHDL::Ast

  class LibraryClause
    RbVHDL::Writer._write_directive(self, {:keyword   => "library",
                                           :format    => "%{indent}%<keyword>-7s %{identifier_list};",
                                           :separator => ", "
                                          }
                                   )
    def _write_line(directive={})
      indent    = directive.fetch(:indent   , "")
      format    = directive.fetch(:format   , self.class._write_directive[:format   ])
      keyword   = directive.fetch(:keyword  , self.class._write_directive[:keyword  ])
      separator = directive.fetch(:separator, self.class._write_directive[:separator])
      identifier_list = @_identifier_list.map{|identifier| identifier._write_string}.join(separator)
      return [ format % {indent: indent, keyword: keyword, identifier_list: identifier_list} ]
    end
  end

end
