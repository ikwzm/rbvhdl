module RbVHDL::Ast

  class Interface

    class Variable
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "variable"})
      def _write_keyword_string(directive={})
        return directive.fetch(:variable_keyword, self.class::WRITE_DIRECTIVE[:keyword])
      end
    end
  end
end

