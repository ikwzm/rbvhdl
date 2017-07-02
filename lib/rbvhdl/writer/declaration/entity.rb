require_relative '../interface/generic'
require_relative '../interface/port'
require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Declaration

    class Entity

      WRITE_DIRECTIVE = {
        :reserved_words           => RbVHDL::Writer::RESERVED_WORDS,
        :entity_begin_format      => "%{indent}%<_entity_>-7s %{identifier} %{_is_}",
        :entity_end_format        => "%{indent}%<_end_>-7s %{identifier};",
        :statement_begin_format   => "%{indent}%{_begin_}",
        :statement_indent         => "    ",
      }.merge( RbVHDL::Writer::Interface::Generic::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Interface::Port::WRITE_DIRECTIVE    )
       .merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE        )
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE          )

      def _write_line(directive={})
        write_line = []
        indent     = directive.fetch(:indent, "")
        identifier = @_identifier._write_string
  
        reserved_words      = directive.fetch(:reserved_words     , WRITE_DIRECTIVE[:reserved_words     ])
        entity_begin_format = directive.fetch(:entity_begin_format, WRITE_DIRECTIVE[:entity_begin_format])
        entity_end_format   = directive.fetch(:entity_end_format  , WRITE_DIRECTIVE[:entity_end_format  ])

        write_line.push entity_begin_format % {
          :indent         => indent,
          :_entity_       => reserved_words[:entity],
          :identifier     => identifier,
          :_is_           => reserved_words[:is]
        }

        write_line.concat(_write_generic_interface(directive))
        write_line.concat(_write_port_interface(directive))

        write_line.push entity_end_format   % {
          :indent         => indent,
          :_entity_       => reserved_words[:entity],
          :identifier     => identifier,
          :_end_          => reserved_words[:end]
        }

        return write_line
      end
      
      include RbVHDL::Writer::Interface::Generic::WriteInterface
      include RbVHDL::Writer::Interface::Port::WriteInterface
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

  end
end
