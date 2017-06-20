require_relative '../declaration/write_declarative_item_list'

module RbVHDL::Ast

  module Declaration

    class ArchitectureBody

      WRITE_DIRECTIVE = {
        :keyword                      => "architecture",
        :of_keyword                   => "of",
        :is_keyword                   => "is",
        :begin_keyword                => "begin",
        :end_keyword                  => "end",
        :architecture_begin_format    => "%{indent}%<keyword>-7s %{identifier} %{of_keyword} %{entity_name} %{is_keyword}",
        :architecture_end_format      => "%{indent}%<end_keyword>-7s %{identifier};",
        :statement_begin_format       => "%{indent}%{begin_keyword}",
        :statement_indent             => "    ",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE )

      def _write_line(directive={})
        write_line  = []
        indent      = directive.fetch(:indent, "")
        identifier  = @_identifier._write_string
        entity_name = @_entity_name._write_string
    
        keyword                   = directive.fetch(:architecture_keyword     , WRITE_DIRECTIVE[:keyword                  ])
        is_keyword                = directive.fetch(:is_keyword               , WRITE_DIRECTIVE[:is_keyword               ])
        of_keyword                = directive.fetch(:of_keyword               , WRITE_DIRECTIVE[:of_keyword               ])
        begin_keyword             = directive.fetch(:begin_keyword            , WRITE_DIRECTIVE[:begin_keyword            ])
        end_keyword               = directive.fetch(:end_keyword              , WRITE_DIRECTIVE[:end_keyword              ])
        architecture_begin_format = directive.fetch(:architecture_begin_format, WRITE_DIRECTIVE[:architecture_begin_format])
        architecture_end_format   = directive.fetch(:architecture_end_format  , WRITE_DIRECTIVE[:architecture_end_format  ])
        declaration_indent        = directive.fetch(:declaration_indent       , WRITE_DIRECTIVE[:declaration_indent       ])
        statement_begin_format    = directive.fetch(:statement_begin_format   , WRITE_DIRECTIVE[:statement_begin_format   ])
        statement_indent          = directive.fetch(:statement_indent         , WRITE_DIRECTIVE[:statement_indent         ])

        write_line.push(architecture_begin_format % {:indent      => indent     ,
                                                     :keyword     => keyword    ,
                                                     :identifier  => identifier ,
                                                     :of_keyword  => of_keyword ,
                                                     :entity_name => entity_name,
                                                     :is_keyword  => is_keyword ,
                        })

        write_line.concat(_write_declarative_item_list(directive))

        write_line.push(statement_begin_format    % {indent: indent, begin_keyword: begin_keyword})

        write_line.concat(_write_statement_list(directive))

        write_line.push(architecture_end_format   % {indent: indent, end_keyword: end_keyword, keyword: keyword, identifier: identifier})

        return write_line
      end
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::Methods::StatementList
    end

  end
end
