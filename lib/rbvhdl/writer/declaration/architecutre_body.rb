require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/write_statement_list'

module RbVHDL::Ast

  module Declaration

    class ArchitectureBody

      WRITE_DIRECTIVE = {
        :reserved_words               => RbVHDL::Writer::RESERVED_WORDS,
        :architecture_begin_format    => "%{indent}%{_architecture_} %{identifier} %{_of_} %{entity_name} %{_is_}",
        :architecture_end_format      => "%{indent}%{_end_} %{identifier};",
        :statement_begin_format       => "%{indent}%{_begin_}",
        :statement_indent             => "    ",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE   )

      def _write_line(directive={})
        write_line  = []
        indent      = directive.fetch(:indent, "")
        identifier  = @_identifier._write_string
        entity_name = @_entity_name._write_string
    
        reserved_words            = directive.fetch(:reserved_words           , WRITE_DIRECTIVE[:reserved_words           ])
        architecture_begin_format = directive.fetch(:architecture_begin_format, WRITE_DIRECTIVE[:architecture_begin_format])
        architecture_end_format   = directive.fetch(:architecture_end_format  , WRITE_DIRECTIVE[:architecture_end_format  ])
        declaration_indent        = directive.fetch(:declaration_indent       , WRITE_DIRECTIVE[:declaration_indent       ])
        statement_begin_format    = directive.fetch(:statement_begin_format   , WRITE_DIRECTIVE[:statement_begin_format   ])
        statement_indent          = directive.fetch(:statement_indent         , WRITE_DIRECTIVE[:statement_indent         ])

        write_line.push architecture_begin_format % {
          :indent          => indent     ,
          :_architecture_  => reserved_words[:architecture],
          :identifier      => identifier ,
          :_of_            => reserved_words[:of],
          :entity_name     => entity_name,
          :_is_            => reserved_words[:is],
        }

        write_line.concat _write_declarative_item_list(directive)

        write_line.push   statement_begin_format    % {:indent => indent, :_begin_ => reserved_words[:begin]}

        write_line.concat _write_statement_list(directive)

        write_line.push   architecture_end_format   % {
          :indent          => indent,
          :_end_           => reserved_words[:end],
          :_entity_        => reserved_words[:entity],
          :identifier      => identifier ,
        }

        return write_line
      end
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

  end
end
