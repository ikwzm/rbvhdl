
module RbVHDL::Writer

  module Declaration

    module SubProgram

      WRITE_DIRECTIVE = {
        :is_keyword             => "is",
        :end_keyword            => "end",
        :proc_spec_format       => "%{indent}%{keyword} %{identifier}%{parameter}",
        :proc_end_format        => "%{indent}%{end_keyword} %{keyword};",
        :keyword_format         => "%<keyword>-9s",
        :parameter_format       => "(%{parameter_list})",
        :identifier_format      => "%{identifier}",
        :identifier_align       => true,
      }

      module WriteSpec
        def _write_specification(directive={})
        end
      end

      module WriteDecl
        def _write_line(directive={})
        end
      end

      module WriteBody
        def _write_line(directive={})
        end
      end

    end
  end
end

module RbVHDL::Ast
  module Declaration

    class ProcedureDecl
      WRITE_DIRECTIVE = {
        :keyword                => "procedure",
      }.merge( RbVHDL::Writer::Declaration::SubProgram::WRITE_DIRECTIVE)
    end

    class ProcedureBody
    end
  
    class FunctionDecl
    end
  
    class FunctionBody
    end

    class PureFunctionDecl
    end

    class ImpureFunctionDecl
    end

    class PureFunctionBody
    end

    class ImpureFunctionBody
    end
  end
end
