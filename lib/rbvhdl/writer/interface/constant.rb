module RbVHDL::Ast

  class Interface

    class Constant
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "constant"})
    end
  end
end

