module RbVHDL::Ast

  module Declaration
    #
    # file_declaration : "file" identifier [,identifier]* ":" subtype_indication [ [ "open" file_open_kind_expresion ] "is" string_expression ] ";"
    #
    class File
      attr_reader   :_owner
      attr_reader   :_identifier_list     # Array of RbVHDL::Ast::Type::Indication
      attr_reader   :_subtype_indication  # RbVHDL::Ast::Type::Indication
      attr_reader   :_open_expression     # RbVHDL::Ast::Expression
      attr_reader   :_string_expression   # RbVHDL::Ast::Expression
      attr_reader   :_annotation

      def initialize(owner, identifier_list, subtype_indication, open_expression, string_expression)
        @_owner              = owner
        @_identifier_list    = identifier_list
        @_subtype_indication = subtype_indication
        @_open_expression    = open_expression
        @_string_expression  = string_expression
        @_annotation         = Hash.new
      end
    end
  end

  def self.file_declaration(owner, ident, type, open=nil, string=nil)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    open_expression    = RbVHDL::Ast.expression_or_nil(open)
    string_expression  = RbVHDL::Ast.expression_or_nil(open)
    return RbVHDL::Ast::Declaration::File.new(owner, identifier_list, subtype_indication, open_expression, string_expression)
  end

end
