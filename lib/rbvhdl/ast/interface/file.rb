module RbVHDL::Ast

  class Interface

    class File < Interface
      def initialize(owner, identifier_list, subtype_indication)
        super(owner, identifier_list, subtype_indication, nil, nil)
      end
    end
  end

  def self.interface_file_declaration(owner, ident, type)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    return RbVHDL::Ast::Interface::File.new(owner, identifier_list, subtype_indication)
  end
  
end

