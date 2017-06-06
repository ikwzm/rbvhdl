module RbVHDL::Ast::Declaration

  class UseClause
    RbVHDL::Writer._write_directive(self, {:keyword   => "use    ",
                                           :format    => "%{indent}%{keyword} %{name_list};",
                                           :separator => ", "
                                          }
                                   )
    def _write_line(directive={})
      indent    = directive.fetch(:indent   , "")
      format    = directive.fetch(:format   , self.class._write_directive[:format   ])
      keyword   = directive.fetch(:keyword  , self.class._write_directive[:keyword  ])
      separator = directive.fetch(:separator, self.class._write_directive[:separator])
      name_list = @_name_list.map{|name| name._write_string({})}.join(separator)
      return [ format % {indent: indent, keyword: keyword, name_list: name_list} ]
    end
  end
end

