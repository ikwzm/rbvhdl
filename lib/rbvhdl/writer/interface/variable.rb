module RbVHDL::Ast

  class Interface

    class Variable
      WRITE_DIRECTIVE = {:class => :variable}.merge(RbVHDL::Ast::Interface::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
    end

  end
end
