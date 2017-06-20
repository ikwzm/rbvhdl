module RbVHDL::Ast

  class Interface

    class File
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "file"})
      def _write_keyword_string(directive={})
        return directive.fetch(:file_keyword, self.class::WRITE_DIRECTIVE[:keyword])
      end
    end

  end
end
