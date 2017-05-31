module RbVHDL::Ast

  module Declaration
    #
    # signal_declaration : "signal" identifier [,identifier]* ":" subtype_indication [ "register" | "bus" ] [ ":=" expression ] ";"
    #
    class Signal
      attr_reader   :_owner
      attr_reader   :_identifier_list     # Array of RbVHDL::Ast::Type::Indication
      attr_reader   :_subtype_indication  # RbVHDL::Ast::Type::Indication
      attr_reader   :_value_expression    # RbVHDL::Ast::Expression
      attr_reader   :_mode                # Symbol :register | :bus
      attr_reader   :_annotation

      def initialize(owner, identifier_list, subtype_indication, value_expression, mode)
        @_owner              = owner
        @_identifier_list    = identifier_list
        @_subtype_indication = subtype_indication
        @_value_expression   = value_expression
        @_mode               = mode
        @_annotation         = Hash.new
      end
    end
  end

  def self.signal_declaration(owner, ident, type, value=nil, mode=nil)
    identifier_list    = RbVHDL::Ast.identifier_list(ident)
    subtype_indication = RbVHDL::Ast.subtype_indication(type)
    value_expression   = RbVHDL::Ast.expression_or_nil(value)
    return RbVHDL::Ast::Declaration::Signal.new(owner, identifier_list, subtype_indication, value_expression, mode)
  end

end
