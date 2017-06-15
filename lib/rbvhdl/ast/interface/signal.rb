module RbVHDL::Ast

  class Interface

    class Signal < Interface
      def initialize(owner, identifier_list, subtype_indication, mode, static_expression)
        super(owner, identifier_list, subtype_indication, mode, static_expression)
      end
    end
  end

  def self.interface_signal_declaration(owner, ident, type, mode=nil, value=nil)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    static_expression  = RbVHDL::Ast.expression_or_nil(value)
    return RbVHDL::Ast::Interface::Signal.new(owner, identifier_list, subtype_indication, mode, static_expression)
  end

end
