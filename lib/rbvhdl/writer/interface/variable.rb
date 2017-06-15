module RbVHDL::Ast

  class Interface

    class Variable
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "variable"})
    end
  end
end

