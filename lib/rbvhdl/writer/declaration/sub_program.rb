require_relative '../interface/parameter'
require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/write_statement_list'

module RbVHDL::Writer

  module Declaration

    module SubProgram

      WRITE_DIRECTIVE = {
        :is_keyword              => "is",
        :begin_keyword           => "begin",
        :end_keyword             => "end",
        :decl_format             => "%{indent}%{spec};",
        :body_begin_format       => "%{indent}%{spec} is",
        :statement_begin_format  => "%{indent}%{begin_keyword}",
        :body_end_format         => "%{indent}%{end_keyword} %{keyword};",
        :parameter_format        => "(%{parameter_list})",
        :identifier_format       => "%{identifier}",
        :identifier_align        => false,
      }

      module WriteDecl

        def _write_line(directive={})
          indent = directive.fetch(:indent     , "")
          format = directive.fetch(:decl_format, self.class::WRITE_DIRECTIVE[:decl_format])
          return (format % {indent: indent, spec: _write_specification(directive)}).split(/\n/)
        end

        def _write_identifier_string(directive={})
          return @_identifier._write_string
        end
      end

      module WriteBody

        def _write_line(directive={})
          indent                  = directive.fetch(:indent, "")
          identifier              = @_identifier._write_string
          class_keyword           = self.class::WRITE_DIRECTIVE[:class_keyword]
          keyword                 = directive.fetch(class_keyword           , self.class::WRITE_DIRECTIVE[:keyword                ])
          is_keyword              = directive.fetch(:is_keyword             , self.class::WRITE_DIRECTIVE[:is_keyword             ])
          begin_keyword           = directive.fetch(:begin_keyword          , self.class::WRITE_DIRECTIVE[:begin_keyword          ])
          end_keyword             = directive.fetch(:end_keyword            , self.class::WRITE_DIRECTIVE[:end_keyword            ])
          body_begin_format       = directive.fetch(:body_begin_format      , self.class::WRITE_DIRECTIVE[:body_begin_format      ])
          statement_begin_format  = directive.fetch(:statement_begin_format , self.class::WRITE_DIRECTIVE[:statement_begin_format ])
          body_end_format         = directive.fetch(:body_end_format        , self.class::WRITE_DIRECTIVE[:body_end_format        ])

          write_line = (body_begin_format  % {indent: indent, spec: _write_specification(directive)}).split(/\n/)

          write_line.concat(_write_declarative_item_list(directive))

          write_line.push(statement_begin_format % {indent: indent, begin_keyword: begin_keyword})

          write_line.concat(_write_statement_list(directive))

          write_line.push(body_end_format  % {indent: indent, end_keyword: end_keyword, keyword: keyword, identifier: identifier})

          return write_line
        end

        def _write_identifier_string(directive={})
          return @_identifier._write_string
        end
      end
    end

    module Procedure
      
      WRITE_DIRECTIVE = {
        :class_keyword  => :procedure_keyword,
        :keyword        => "procedure",
        :keyword_format => "%<keyword>-9s",
        :spec_format    => "%{keyword} %{identifier}%{parameter}",
      }.merge( RbVHDL::Writer::Declaration::SubProgram::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Interface::Parameter::WRITE_DIRECTIVE    )
        
      module WriteSpec

        def _write_specification(directive={})
          indent            = directive.fetch(:indent, "")
          identifier        = @_identifier._write_string
          class_keyword     = self.class::WRITE_DIRECTIVE[:class_keyword]
          keyword           = directive.fetch(class_keyword     , self.class::WRITE_DIRECTIVE[:keyword           ])
          spec_format       = directive.fetch(:spec_format      , self.class::WRITE_DIRECTIVE[:spec_format       ])
          keyword_format    = directive.fetch(:keyword_format   , self.class::WRITE_DIRECTIVE[:keyword_format    ])
          identifier_format = directive.fetch(:identifier_format, self.class::WRITE_DIRECTIVE[:identifier_format ])

          param_directive   = directive.dup
          param_directive[:param_begin_format] = spec_format  % {:keyword    => keyword_format    % {:keyword    => keyword   },
                                                                 :identifier => identifier_format % {:identifier => identifier},
                                                                 :parameter  => "("
          }
          param_directive[:param_end_format  ] = "%{indent})" % {:indent     => indent}
          return self._write_parameter_interface(param_directive).join("\n")
        end
      end

    end

    module Function
      
      WRITE_DIRECTIVE = {
        :class_keyword  => :function_keyword,
        :keyword        => "function",
        :keyword_format => "%<keyword>-9s",
        :spec_format    => "%{prefix}%{keyword} %{identifier}%{parameter}",
        :prefix_format  => "%<prefix>-7s",
        :return_keyword => "return",
        :return_format  => "%{return_keyword} %{return_type}"
      }.merge( RbVHDL::Writer::Declaration::SubProgram::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Interface::Parameter::WRITE_DIRECTIVE    )
        
      module WriteSpec

        def _write_specification(directive={})
          indent            = directive.fetch(:indent, "")
          identifier        = @_identifier._write_string
          class_keyword     = self.class::WRITE_DIRECTIVE[:class_keyword]
          keyword           = directive.fetch(class_keyword     , self.class::WRITE_DIRECTIVE[:keyword          ])
          return_keyword    = directive.fetch(:return_keyword   , self.class::WRITE_DIRECTIVE[:return_keyword   ])
          spec_format       = directive.fetch(:spec_format      , self.class::WRITE_DIRECTIVE[:spec_format      ])
          keyword_format    = directive.fetch(:keyword_format   , self.class::WRITE_DIRECTIVE[:keyword_format   ])
          identifier_format = directive.fetch(:identifier_format, self.class::WRITE_DIRECTIVE[:identifier_format])
          return_format     = directive.fetch(:return_format    , self.class::WRITE_DIRECTIVE[:return_format    ])

          prefix_keyword    = self.class::WRITE_DIRECTIVE[:prefix_keyword]
          if prefix_keyword.nil?  then
            prefix          = ""
          else
            prefix_format   = directive.fetch(:prefix_format    , self.class::WRITE_DIRECTIVE[:prefix_format    ])
            prefix          = prefix_format % {:prefix => 
                              directive.fetch(prefix_keyword    , self.class::WRITE_DIRECTIVE[prefix_keyword    ])}
          end

          param_directive   = directive.dup
          param_directive[:param_begin_format] = spec_format % {:prefix     => prefix,
                                                                :keyword    => keyword_format    % {:keyword    => keyword   },
                                                                :identifier => identifier_format % {:identifier => identifier},
                                                                :parameter  => "("
          }
          # param_directive[:param_mode_format ] = ":  "
          param_directive[:return_keyword    ] = return_keyword
          param_directive[:return_type       ] = self._type_mark
          return self._write_parameter_interface(param_directive).join("\n")
        end
      end

    end
  end
end

module RbVHDL::Ast

  module Declaration

    class ProcedureDecl
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Procedure::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Procedure::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end

    class ProcedureBody
      WRITE_DIRECTIVE = {
      }.merge( RbVHDL::Writer::Declaration::Procedure::WRITE_DIRECTIVE)
       .merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           )
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE             )
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Procedure::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end
  
    class FunctionDecl
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end
  
    class FunctionBody
      WRITE_DIRECTIVE = {
      }.merge( RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           )
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE             )
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

    class PureFunctionDecl
      WRITE_DIRECTIVE = {
        :prefix_keyword => :pure_keyword,
        :pure_keyword   => "pure",
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end

    class ImpureFunctionDecl
      WRITE_DIRECTIVE = {
        :prefix_keyword => :impure_keyword,
        :impure_keyword => "impure",
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end

    class PureFunctionBody
      WRITE_DIRECTIVE = {
        :prefix_keyword => :pure_keyword,
        :pure_keyword   => "pure",
      }.merge( RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           )
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE             )
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

    class ImpureFunctionBody
      WRITE_DIRECTIVE = {
        :prefix_keyword => :impure_keyword,
        :impure_keyword => "impure",
      }.merge( RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           )
       .merge( RbVHDL::Writer::Statement::WRITE_DIRECTIVE             )
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

  end
end
