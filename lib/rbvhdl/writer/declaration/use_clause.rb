module RbVHDL::Ast

  module Declaration

    class UseClause
      WRITE_DIRECTIVE = {:keyword => "use", :format => "%{indent}%<keyword>-7s %{name_list};", :separator => ", "}

      def _write_line(directive={})
        indent    = directive.fetch(:indent   , "")
        format    = directive.fetch(:format   , WRITE_DIRECTIVE[:format   ])
        keyword   = directive.fetch(:keyword  , WRITE_DIRECTIVE[:keyword  ])
        separator = directive.fetch(:separator, WRITE_DIRECTIVE[:separator])
        name_list = @_name_list.map{|name| name._write_string({})}.join(separator)
        return [ format % {indent: indent, keyword: keyword, name_list: name_list} ]
      end
    end

  end
end

