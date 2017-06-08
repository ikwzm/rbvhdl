module RbVHDL::Ast
  module Interface

    class File
      attr_reader   :_owner
      attr_reader   :_identifier_list
      attr_reader   :_subtype_indication
      attr_reader   :_mode
      attr_reader   :_static_expression
      attr_reader   :_annotation

      def initialize(owner, identifier_list, subtype_indication)
        @_owner              = owner
        @_identifier_list    = identifier_list
        @_subtype_indication = subtype_indication
        @_mode               = nil
        @_static_expression  = nil
        @_annotation         = Hash.new
      end
    end
  end

  def self.interface_file_declaration(owner, ident, type)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    return RbVHDL::Ast::Interface::File.new(owner, identifier_list, subtype_indication)
  end
  
end

