module RbVHDL::Ast

  class Interface

    class Signal
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "signal"})
      def _write_keyword_string(directive={})
        return directive.fetch(:signal_keyword, self.class::WRITE_DIRECTIVE[:keyword])
      end
    end
  end
end

