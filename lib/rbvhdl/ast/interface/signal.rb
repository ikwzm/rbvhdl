module RbVHDL::Ast
  module Interface

    class Signal
      attr_reader   :_owner
      attr_reader   :_identifier_list
      attr_reader   :_subtype_indication
      attr_reader   :_mode
      attr_reader   :_static_expression
      attr_reader   :_annotation

      def initialize(owner, identifier_list, subtype_indication, mode, static_expression)
        @_owner              = owner
        @_identifier_list    = identifier_list
        @_subtype_indication = subtype_indication
        @_mode               = mode
        @_static_expression  = static_expression
        @_annotation         = Hash.new
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
