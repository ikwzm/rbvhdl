module RbVHDL::Ast

  class Interface

    class Signal
      WRITE_DIRECTIVE = {:class => :signal  }.merge(RbVHDL::Ast::Interface::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
    end

  end
end
