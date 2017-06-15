module RbVHDL::Ast

  class Interface

    class Constant
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "constant"})
      def _write_keyword_string(directive={})
        return directive.fetch(:constant_keyword, self.class::WRITE_DIRECTIVE[:keyword])
      end
    end
  end
end

