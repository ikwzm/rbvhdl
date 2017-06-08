require_relative '../declaration/methods'
require_relative '../interface/methods'
require_relative '../statement/methods'

module RbVHDL::Ast

  module Declaration

    class Entity
      RbVHDL::Writer._write_directive(self, {:keyword                  => "entity",
                                             :is_keyword               => "is",
                                             :end_keyword              => "end",
                                             :entity_begin_format      => "%{indent}%<keyword>-7s %{identifier} %{is_keyword}",
                                             :entity_end_format        => "%{indent}%<end_keyword>-7s %{identifier};",
                                             :generic_keyword          => "generic",
                                             :generic_begin_format     => "%{indent}%{generic_indent}%{generic_keyword}(" , 
                                             :generic_end_format       => "%{indent}%{generic_indent});", 
                                             :generic_indent           => "    ",
                                             :generic_interface_format => "%{indent}%<identifier>-16s :  %{type}%{value}%{separator}",
                                             :generic_interface_indent => "    ",
                                             :generic_separator        => ";"   ,
                                             :port_keyword             => "port",
                                             :port_begin_format        => "%{indent}%{port_indent}%{port_keyword}(",
                                             :port_end_format          => "%{indent}%{port_indent});",
                                             :port_indent              => "    ",
                                             :port_interface_format    => "%{indent}%<identifier>-16s :  %{mode} %{type}%{value}%{separator}",
                                             :port_interface_indent    => "    ",
                                             :port_separator           => ";"   ,
                                             :declaration_indent       => "    ",
                                             :begin_keyword            => "begin",
                                             :statement_begin_format   => "%{indent}%{begin_keyword}",
                                             :statement_indent         => "    ",
                                            }
                                     )
      def _write_line(directive={})
        write_line = []
        indent     = directive.fetch(:indent, "")
        identifier = @_identifier._write_string
  
        keyword             = directive.fetch(:keyword            , self.class._write_directive[:keyword            ])
        is_keyword          = directive.fetch(:is_keyword         , self.class._write_directive[:is_keyword         ])
        end_keyword         = directive.fetch(:end_keyword        , self.class._write_directive[:end_keyword        ])
        entity_begin_format = directive.fetch(:entity_begin_format, self.class._write_directive[:entity_begin_format])
        entity_end_format   = directive.fetch(:entity_end_format  , self.class._write_directive[:entity_end_format  ])
        write_line.push(entity_begin_format % {indent: indent, keyword: keyword, identifier: identifier, is_keyword: is_keyword})

        write_line.concat(_write_generic_interface(directive))
        write_line.concat(_write_port_interface(directive))

        write_line.push(entity_end_format   % {indent: indent, end_keyword: end_keyword, keyword: keyword, identifier: identifier})

        return write_line
      end
      
      include RbVHDL::Writer::Interface::Methods::Generic
      include RbVHDL::Writer::Interface::Methods::Port
      include RbVHDL::Writer::Declaration::Methods
      include RbVHDL::Writer::Statement::Methods
    end

  end
end
