module RbVHDL::Ast

  module Declaration
    #
    # variable_declaration : "variable" identifier [,identifier]* ":" subtype_indication [ ":=" expression ] ";"
    #
    class Variable
      attr_reader   :_owner
      attr_reader   :_identifier_list     # Array of RbVHDL::Ast::Type::Indication
      attr_reader   :_subtype_indication  # RbVHDL::Ast::Type::Indication
      attr_reader   :_value_expression    # RbVHDL::Ast::Expression
      attr_reader   :_annotation

      def initialize(owner, identifier_list, subtype_indication, value_expression)
        @_owner              = owner
        @_identifier_list    = identifier_list
        @_subtype_indication = subtype_indication
        @_value_expression   = value_expression
        @_annotation         = Hash.new
      end
    end
  end

  def self.variable_declaration(owner, ident, type, value=nil)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    value_expression   = RbVHDL::Ast.expression_or_nil(value)
    return RbVHDL::Ast::Declaration::Variable.new(owner, identifier_list, subtype_indication, value_expression)
  end

end
