module RbVHDL::Ast::Interface

  class Constant

    WRITE_DIRECTIVE = {
      :keyword => "constant",
    }.merge(RbVHDL::Writer::Interface::WRITE_DIRECTIVE)

    include RbVHDL::Writer::Interface::WriteMethods
  end
end

