module RbVHDL::Ast

  module Declaration

    class Constant
      attr_reader   :_owner
      attr_reader   :_identifier_list
      attr_reader   :_subtype_indication
      attr_reader   :_value_expression
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

  def self.constant_declaration(owner, ident, type, value=nil)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    value_expression   = RbVHDL::Ast.expression_or_nil(value)
    return RbVHDL::Ast::Declaration::Constant.new(owner, identifier_list, subtype_indication, value_expression)
  end

end
