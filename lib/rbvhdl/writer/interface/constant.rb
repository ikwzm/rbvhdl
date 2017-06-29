module RbVHDL::Ast

  class Interface

    class Constant
      WRITE_DIRECTIVE = {:class => :constant}.merge(RbVHDL::Ast::Interface::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
    end

  end
end
