module RbVHDL::Ast

  module Declaration

    class File
      attr_reader   :_owner
      attr_reader   :_identifier_list
      attr_reader   :_subtype_indication
      attr_reader   :_open
      attr_reader   :_string
      attr_reader   :_annotation

      def initialize(owner, identifier_list, subtype_indication, open, string)
        @_owner              = owner
        @_identifier_list    = identifier_list
        @_subtype_indication = subtype_indication
        @_open               = open
        @_string             = string
        @_annotation         = Hash.new
      end
    
    end

  end

  def self.file_declaration(owner, ident, type, open=nil, string=nil)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    return RbVHDL::Ast::Declaration::File.new(owner, identifier_list, subtype_indication, open, string)
  end

end
