module RbVHDL::Ast

  class Interface

    class File
      WRITE_DIRECTIVE = {:class => :file    }.merge(RbVHDL::Ast::Interface::WRITE_DIRECTIVE){|key, base_val, default_val| base_val}
    end

  end
end
