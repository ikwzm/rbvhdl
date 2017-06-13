require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/methods'
require_relative '../interface/generic'
require_relative '../interface/port'

module RbVHDL::Ast::Declaration

  class Entity

    WRITE_DIRECTIVE = {
      :keyword                  => "entity",
      :is_keyword               => "is",
      :end_keyword              => "end",
      :entity_begin_format      => "%{indent}%<keyword>-7s %{identifier} %{is_keyword}",
      :entity_end_format        => "%{indent}%<end_keyword>-7s %{identifier};",
      :begin_keyword            => "begin",
      :statement_begin_format   => "%{indent}%{begin_keyword}",
      :statement_indent         => "    ",
    }.merge( RbVHDL::Writer::Interface::Generic::WRITE_DIRECTIVE )
     .merge( RbVHDL::Writer::Interface::Port::WRITE_DIRECTIVE    )
     .merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE        )

    def _write_line(directive={})
      write_line = []
      indent     = directive.fetch(:indent, "")
      identifier = @_identifier._write_string
  
      keyword             = directive.fetch(:entity_keyword     , WRITE_DIRECTIVE[:keyword            ])
      is_keyword          = directive.fetch(:is_keyword         , WRITE_DIRECTIVE[:is_keyword         ])
      end_keyword         = directive.fetch(:end_keyword        , WRITE_DIRECTIVE[:end_keyword        ])
      entity_begin_format = directive.fetch(:entity_begin_format, WRITE_DIRECTIVE[:entity_begin_format])
      entity_end_format   = directive.fetch(:entity_end_format  , WRITE_DIRECTIVE[:entity_end_format  ])

      write_line.push(entity_begin_format % {indent: indent, keyword: keyword, identifier: identifier, is_keyword: is_keyword})

      write_line.concat(_write_generic_interface(directive))
      write_line.concat(_write_port_interface(directive))

      write_line.push(entity_end_format   % {indent: indent, keyword: keyword, identifier: identifier, end_keyword: end_keyword})

      return write_line
    end
      
    include RbVHDL::Writer::Interface::Generic::WriteInterface
    include RbVHDL::Writer::Interface::Port::WriteInterface
    include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
    include RbVHDL::Writer::Statement::Methods::StatementList
  end
end
