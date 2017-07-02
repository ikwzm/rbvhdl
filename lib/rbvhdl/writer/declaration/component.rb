require_relative '../interface/generic'
require_relative '../interface/port'

module RbVHDL::Ast

  module Declaration

    class Component

      WRITE_DIRECTIVE = {
        :reserved_words           => RbVHDL::Writer::RESERVED_WORDS,
        :component_begin_format   => "%{indent}%{keyword} %{identifier} %{_is_}",
        :component_end_format     => "%{indent}%{_end_} %{_component_};",
        :keyword_format           => "%<keyword>-9s",
      }.merge( RbVHDL::Writer::Interface::Generic::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Interface::Port::WRITE_DIRECTIVE    )
       .merge( {
        :generic_interface_indent => "      ",
        :port_interface_indent    => "      ",
      })

      def _write_line(directive={})
        write_line = []
        indent     = directive.fetch(:indent, "")
        identifier = @_identifier._write_string
  
        reserved_words         = directive.fetch(:reserved_words        , WRITE_DIRECTIVE[:reserved_words        ])
        keyword_format         = directive.fetch(:keyword_format        , WRITE_DIRECTIVE[:keyword_format        ])
        component_begin_format = directive.fetch(:component_begin_format, WRITE_DIRECTIVE[:component_begin_format])
        component_end_format   = directive.fetch(:component_end_format  , WRITE_DIRECTIVE[:component_end_format  ])

        write_line.push   component_begin_format % {
          :indent      => indent,
          :keyword     => keyword_format  % {:keyword => reserved_words[:component]},
          :identifier  => identifier,
          :_is_        => reserved_words[:is]
        }

        write_line.concat _write_generic_interface(directive)
        write_line.concat _write_port_interface(directive)

        write_line.push   component_end_format   % {
          :indent      => indent,
          :_component_ => reserved_words[:component],
          :identifier  => identifier,
          :_end_       => reserved_words[:end],
        }

        return write_line
      end
      
      include RbVHDL::Writer::Interface::Generic::WriteInterface
      include RbVHDL::Writer::Interface::Port::WriteInterface
    end

  end
end
