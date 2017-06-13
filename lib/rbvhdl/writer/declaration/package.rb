require_relative '../declaration/write_declarative_item_list'

module RbVHDL::Ast::Declaration

  class Package
    WRITE_DIRECTIVE = {
      :keyword                  => "package",
      :is_keyword               => "is",
      :end_keyword              => "end",
      :package_begin_format     => "%{indent}%<keyword>-7s %{identifier} %{is_keyword}",
      :package_end_format       => "%{indent}%<end_keyword>-7s %{identifier};",
    }.merge(RbVHDL::Write::Declaration::WRITE_DIRECTIVE)

    def _write_line(directive={})
      write_line  = []
      indent      = directive.fetch(:indent, "")
      identifier  = @_identifier._write_string
      entity_name = @_entity_name._write_string
    
      keyword              = directive.fetch(:package_keyword     , WRITE_DIRECTIVE[:keyword             ])
      is_keyword           = directive.fetch(:is_keyword          , WRITE_DIRECTIVE[:is_keyword          ])
      of_keyword           = directive.fetch(:of_keyword          , WRITE_DIRECTIVE[:of_keyword          ])
      end_keyword          = directive.fetch(:end_keyword         , WRITE_DIRECTIVE[:end_keyword         ])
      package_begin_format = directive.fetch(:package_begin_format, WRITE_DIRECTIVE[:package_begin_format])
      package_end_format   = directive.fetch(:package_end_format  , WRITE_DIRECTIVE[:package_end_format  ])
      declaration_indent   = directive.fetch(:declaration_indent  , WRITE_DIRECTIVE[:declaration_indent  ])

      write_line.push(package_begin_format % {indent: indent, keyword: keyword, identifier: identifier, is_keyword: is_keyword  })

      write_line.concat(_write_declarative_item_list(directive))

      write_line.push(package_end_format   % {indent: indent, keyword: keyword, identifier: identifier, end_keyword: end_keyword})

      return write_line
    end

    include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
  end
end
