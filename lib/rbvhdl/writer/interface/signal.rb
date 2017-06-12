module RbVHDL::Ast::Interface

  class Signal

    WRITE_DIRECTIVE = {
      :keyword => "signal",
    }.merge(RbVHDL::Writer::Interface::WRITE_DIRECTIVE)

    include RbVHDL::Writer::Interface::WriteMethods
  end
end

