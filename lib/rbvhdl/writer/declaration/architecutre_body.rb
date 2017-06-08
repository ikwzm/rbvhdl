module RbVHDL::Ast::Declaration
  class ArchitectureBody
    RbVHDL::Writer._write_directive(self, {:keyword                      => "architecture",
                                           :of_keyword                   => "of",
                                           :is_keyword                   => "is",
                                           :begin_keyword                => "begin",
                                           :end_keyword                  => "end",
                                           :architecture_begin_format    => "%{indent}%<keyword>-7s %{identifier} %{of_keyword} %{entity_name} %{is_keyword}",
                                           :architecture_end_format      => "%{indent}%<end_keyword>-7s %{identifier};",
                                           :declaration_indent           => "    ",
                                           :declaration_identifier_align => true,
                                           :statement_begin_format       => "%{indent}%{begin_keyword}",
                                           :statement_indent             => "    ",
                                          }
                                   )
    def _write_line(directive={})
      write_line  = []
      indent      = directive.fetch(:indent, "")
      identifier  = @_identifier._write_string
      entity_name = @_entity_name._write_string
    
      keyword                   = directive.fetch(:architecture_keyword     , self.class._write_directive[:keyword                  ])
      is_keyword                = directive.fetch(:is_keyword               , self.class._write_directive[:is_keyword               ])
      of_keyword                = directive.fetch(:of_keyword               , self.class._write_directive[:of_keyword               ])
      begin_keyword             = directive.fetch(:begin_keyword            , self.class._write_directive[:begin_keyword            ])
      end_keyword               = directive.fetch(:end_keyword              , self.class._write_directive[:end_keyword              ])
      architecture_begin_format = directive.fetch(:architecture_begin_format, self.class._write_directive[:architecture_begin_format])
      architecture_end_format   = directive.fetch(:architecture_end_format  , self.class._write_directive[:architecture_end_format  ])
      declaration_indent        = directive.fetch(:declaration_indent       , self.class._write_directive[:declaration_indent       ])
      statement_begin_format    = directive.fetch(:statement_begin_format   , self.class._write_directive[:statement_begin_format   ])
      statement_indent          = directive.fetch(:statement_indent         , self.class._write_directive[:statement_indent         ])

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
    include RbVHDL::Writer::Declaration::Methods::DeclarativeItemList
    include RbVHDL::Writer::Statement::Methods::StatementList
  end
end
