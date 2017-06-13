require_relative '../interface/generic'
require_relative '../interface/port'

module RbVHDL::Ast::Declaration

  class Component

    WRITE_DIRECTIVE = {
      :keyword                  => "component",
      :is_keyword               => "is",
      :end_keyword              => "end",
      :component_begin_format   => "%{indent}%<keyword>-9s %{identifier} %{is_keyword}",
      :component_end_format     => "%{indent}%{end_keyword} %{keyword};",
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
  
      keyword                = directive.fetch(:entity_keyword        , WRITE_DIRECTIVE[:keyword               ])
      is_keyword             = directive.fetch(:is_keyword            , WRITE_DIRECTIVE[:is_keyword            ])
      end_keyword            = directive.fetch(:end_keyword           , WRITE_DIRECTIVE[:end_keyword           ])
      component_begin_format = directive.fetch(:component_begin_format, WRITE_DIRECTIVE[:component_begin_format])
      component_end_format   = directive.fetch(:component_end_format  , WRITE_DIRECTIVE[:component_end_format  ])

      write_line.push(component_begin_format % {indent: indent, keyword: keyword, identifier: identifier, is_keyword: is_keyword})

      write_line.concat(_write_generic_interface(directive))
      write_line.concat(_write_port_interface(directive))

      write_line.push(component_end_format   % {indent: indent, keyword: keyword, identifier: identifier, end_keyword: end_keyword})

      return write_line
    end
      
    include RbVHDL::Writer::Interface::Generic::WriteInterface
    include RbVHDL::Writer::Interface::Port::WriteInterface
  end
end
