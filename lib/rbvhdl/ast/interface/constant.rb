module RbVHDL::Ast

  class Interface

    class Constant < Interface
      def initialize(owner, identifier_list, subtype_indication, mode, static_expression)
        super(owner, identifier_list, subtype_indication, mode, static_expression)
      end
    end
  end
  
  def self.interface_constant_declaration(owner, ident, type, mode=nil, value=nil)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    static_expression  = RbVHDL::Ast.expression_or_nil(value)
    interface_mode     = RbVHDL::Ast.interface_mode_or_nil(mode)
    return RbVHDL::Ast::Interface::Constant.new(owner, identifier_list, subtype_indication, interface_mode, static_expression)
  end

end

