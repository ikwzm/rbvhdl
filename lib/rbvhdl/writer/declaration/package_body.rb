require_relative '../declaration/write_declarative_item_list'

module RbVHDL::Ast

  module Declaration

    class PackageBody

      WRITE_DIRECTIVE = {
        :keyword                   => "package body",
        :is_keyword                => "is",
        :end_keyword               => "end",
        :package_body_begin_format => "%{indent}%{keyword} %{identifier} %{is_keyword}",
        :package_body_end_format   => "%{indent}%{end_keyword} %{identifier};",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE )

      def _write_line(directive={})
        write_line  = []
        indent      = directive.fetch(:indent, "")
        identifier  = @_identifier._write_string
    
        keyword                   = directive.fetch(:package_body_keyword     , WRITE_DIRECTIVE[:keyword                  ])
        is_keyword                = directive.fetch(:is_keyword               , WRITE_DIRECTIVE[:is_keyword               ])
        of_keyword                = directive.fetch(:of_keyword               , WRITE_DIRECTIVE[:of_keyword               ])
        end_keyword               = directive.fetch(:end_keyword              , WRITE_DIRECTIVE[:end_keyword              ])
        package_body_begin_format = directive.fetch(:package_body_begin_format, WRITE_DIRECTIVE[:package_body_begin_format])
        package_body_end_format   = directive.fetch(:package_body_end_format  , WRITE_DIRECTIVE[:package_body_end_format  ])
        declaration_indent        = directive.fetch(:declaration_indent       , WRITE_DIRECTIVE[:declaration_indent       ])

        write_line.push(package_body_begin_format % {indent: indent, keyword: keyword, identifier: identifier, is_keyword: is_keyword  })

        write_line.concat(_write_declarative_item_list(directive))

        write_line.push(package_body_end_format   % {indent: indent, keyword: keyword, identifier: identifier, end_keyword: end_keyword})

        return write_line
      end
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
    end

  end
end
