module RbVHDL::Ast::Interface

  class Variable

    WRITE_DIRECTIVE = {
      :keyword => "variable",
    }.merge(RbVHDL::Writer::Interface::WRITE_DIRECTIVE)

    include RbVHDL::Writer::Interface::WriteMethods
  end
end

