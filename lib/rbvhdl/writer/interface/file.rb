module RbVHDL::Ast

  class Interface

    class File
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "file"})
    end
  end
end

