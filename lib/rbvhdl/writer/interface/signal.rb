module RbVHDL::Ast

  class Interface

    class Signal
      WRITE_DIRECTIVE = RbVHDL::Ast::Interface::WRITE_DIRECTIVE.dup.merge({:keyword => "signal"})
    end
  end
end

