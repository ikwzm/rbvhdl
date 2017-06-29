require_relative '../interface/parameter'
require_relative '../declaration/write_declarative_item_list'
require_relative '../statement/write_statement_list'

module RbVHDL::Writer

  module Declaration

    module SubProgram

      WRITE_DIRECTIVE = {
        :reserved_words          => RbVHDL::Writer::RESERVED_WORDS,
        :decl_format             => "%{indent}%{spec};",
        :body_begin_format       => "%{indent}%{spec} %{_is_}",
        :statement_begin_format  => "%{indent}%{_begin_}",
        :body_end_format         => "%{indent}%{_end_} %{keyword};",
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
          subprogram_class        = self.class::WRITE_DIRECTIVE[:class]
          reserved_words          = directive.fetch(:reserved_words         , self.class::WRITE_DIRECTIVE[:reserved_words         ])
          body_begin_format       = directive.fetch(:body_begin_format      , self.class::WRITE_DIRECTIVE[:body_begin_format      ])
          statement_begin_format  = directive.fetch(:statement_begin_format , self.class::WRITE_DIRECTIVE[:statement_begin_format ])
          body_end_format         = directive.fetch(:body_end_format        , self.class::WRITE_DIRECTIVE[:body_end_format        ])

          write_line = (body_begin_format  % {
            :indent     => indent,
            :spec       => _write_specification(directive),
            :_is_       => reserved_words[:is]
          }).split(/\n/)

          write_line.concat _write_declarative_item_list(directive)

          write_line.push   statement_begin_format % {:indent => indent, :_begin_ => reserved_words[:begin]}

          write_line.concat _write_statement_list(directive)

          write_line.push   body_end_format  % {
            :indent     => indent,
            :_end_      => reserved_words[:end],
            :keyword    => reserved_words[subprogram_class],
            :identifier => identifier
          }

          return write_line
        end

        def _write_identifier_string(directive={})
          return @_identifier._write_string
        end
      end
    end

    module Procedure
      
      WRITE_DIRECTIVE = {
        :class          => :procedure,
        :keyword_format => "%<keyword>-9s",
        :spec_format    => "%{keyword} %{identifier}%{parameter}",
      }.merge( RbVHDL::Writer::Declaration::SubProgram::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Interface::Parameter::WRITE_DIRECTIVE    )
        
      module WriteSpec

        def _write_specification(directive={})
          indent            = directive.fetch(:indent, "")
          identifier        = @_identifier._write_string
          subprogram_class  = self.class::WRITE_DIRECTIVE[:class]
          reserved_words    = directive.fetch(:reserved_words   , self.class::WRITE_DIRECTIVE[:reserved_words    ])
          spec_format       = directive.fetch(:spec_format      , self.class::WRITE_DIRECTIVE[:spec_format       ])
          keyword_format    = directive.fetch(:keyword_format   , self.class::WRITE_DIRECTIVE[:keyword_format    ])
          identifier_format = directive.fetch(:identifier_format, self.class::WRITE_DIRECTIVE[:identifier_format ])

          param_directive   = directive.dup
          param_directive[:param_begin_format] = spec_format  % {
            :keyword    => keyword_format    % {:keyword    => reserved_words[subprogram_class] },
            :identifier => identifier_format % {:identifier => identifier},
            :parameter  => "(",
          }
          param_directive[:param_end_format  ] = "#{indent})"
          return self._write_parameter_interface(param_directive).join("\n")
        end
      end

    end

    module Function
      
      WRITE_DIRECTIVE = {
        :class          => :function,
        :prefix         => nil,
        :keyword_format => "%<keyword>-9s",
        :spec_format    => "%{prefix}%{keyword} %{identifier}%{parameter}",
        :prefix_format  => "%<prefix>-7s",
        :return_format  => "%{_return_} %{return_type}"
      }.merge( RbVHDL::Writer::Declaration::SubProgram::WRITE_DIRECTIVE )
       .merge( RbVHDL::Writer::Interface::Parameter::WRITE_DIRECTIVE    )
        
      module WriteSpec

        def _write_specification(directive={})
          indent            = directive.fetch(:indent, "")
          identifier        = @_identifier._write_string
          subprogram_class  = self.class::WRITE_DIRECTIVE[:class]
          prefix            = self.class::WRITE_DIRECTIVE[:prefix]
          reserved_words    = directive.fetch(:reserved_words   , self.class::WRITE_DIRECTIVE[:reserved_words   ])
          spec_format       = directive.fetch(:spec_format      , self.class::WRITE_DIRECTIVE[:spec_format      ])
          keyword_format    = directive.fetch(:keyword_format   , self.class::WRITE_DIRECTIVE[:keyword_format   ])
          identifier_format = directive.fetch(:identifier_format, self.class::WRITE_DIRECTIVE[:identifier_format])
          prefix_format     = directive.fetch(:prefix_format    , self.class::WRITE_DIRECTIVE[:prefix_format    ])
          return_format     = directive.fetch(:return_format    , self.class::WRITE_DIRECTIVE[:return_format    ])

          param_directive   = directive.dup
          param_directive[:param_begin_format] = spec_format % {
            :prefix     => (prefix.nil?)? "" : prefix_format     % {:prefix     => reserved_words[prefix]          },
            :keyword    =>                     keyword_format    % {:keyword    => reserved_words[subprogram_class]},
            :identifier =>                     identifier_format % {:identifier => identifier                      },
            :parameter  => "("
          }
          # param_directive[:param_mode_format ] = ":  "
          param_directive[:return_type] = self._type_mark
          return self._write_parameter_interface(param_directive).join("\n")
        end
      end

    end
  end
end

module RbVHDL::Ast

  module Declaration

    class ProcedureDecl
      WRITE_DIRECTIVE = {
      }.merge(RbVHDL::Writer::Declaration::Procedure::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Procedure::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end

    class ProcedureBody
      WRITE_DIRECTIVE = {
      }.merge(RbVHDL::Writer::Declaration::Procedure::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           ){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Statement::WRITE_DIRECTIVE             ){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Procedure::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end
  
    class FunctionDecl
      WRITE_DIRECTIVE = {
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end
  
    class FunctionBody
      WRITE_DIRECTIVE = {
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           ){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Statement::WRITE_DIRECTIVE             ){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

    class PureFunctionDecl
      WRITE_DIRECTIVE = {
        :prefix         => :pure,
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end

    class ImpureFunctionDecl
      WRITE_DIRECTIVE = {
        :prefix         => :impure,
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteDecl
    end

    class PureFunctionBody
      WRITE_DIRECTIVE = {
        :prefix         => :pure,
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           ){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Statement::WRITE_DIRECTIVE             ){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

    class ImpureFunctionBody
      WRITE_DIRECTIVE = {
        :prefix         => :impure,
      }.merge(RbVHDL::Writer::Declaration::Function::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Declaration::WRITE_DIRECTIVE           ){|key, base_val, default_val| base_val}
       .merge(RbVHDL::Writer::Statement::WRITE_DIRECTIVE             ){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Interface::Parameter::WriteInterface
      include RbVHDL::Writer::Declaration::Function::WriteSpec
      include RbVHDL::Writer::Declaration::SubProgram::WriteBody
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
      include RbVHDL::Writer::Statement::WriteStatementList
    end

  end
end
