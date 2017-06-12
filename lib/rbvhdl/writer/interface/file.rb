module RbVHDL::Ast::Interface

  class File

    WRITE_DIRECTIVE = {
      :keyword => "file",
    }.merge(RbVHDL::Writer::Interface::WRITE_DIRECTIVE)

    include RbVHDL::Writer::Interface::WriteMethods
  end
end

