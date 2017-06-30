require_relative '../declaration/methods'
require_relative '../association/methods'
require_relative '../interface/methods'
require_relative '../statement/methods'

module RbVHDL::Ast

  module Declaration

    class SubProgram
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_generic_interface_list
      attr_reader   :_generic_association_list
      attr_reader   :_parameter_interface_list
      attr_reader   :_annotation

      def initialize(owner, identifier)
        @_owner                    = owner
        @_identifier               = identifier
        @_generic_interface_list   = []
        @_generic_association_list = []
        @_parameter_interface_list = []
        @_annotation               = Hash.new
      end

      include RbVHDL::Ast::Interface::Methods::Generic
      include RbVHDL::Ast::Association::Methods::Generic
    end

    class SubProgramDecl     < SubProgram
    end

    class SubProgramBody     < SubProgram
      attr_reader   :_declarative_item_list
      attr_reader   :_statement_list
      def initialize(owner, identifier)
        super(owner, identifier)
        @_declarative_item_list = []
        @_statement_list        = []
      end
      include RbVHDL::Ast::Declaration::Methods::SubProgramItem
      include RbVHDL::Ast::Statement::Methods::Sequential
    end

    class ProcedureDecl      < SubProgramDecl
      include RbVHDL::Ast::Interface::Methods::ProcedureParameter
    end

    class ProcedureBody      < SubProgramBody
      include RbVHDL::Ast::Interface::Methods::ProcedureParameter
    end

    class FunctionDecl       < SubProgramDecl
      attr_reader   :_type_mark
      def initialize(owner, identifier, type)
        super(owner, identifier)
        @_type_mark = RbVHDL::Ast.type_mark(type)
      end
      include RbVHDL::Ast::Interface::Methods::FunctionParameter
    end
    
    class FunctionBody       < SubProgramBody
      attr_reader   :_type_mark
      def initialize(owner, identifier, type)
        super(owner, identifier)
        @_type_mark = RbVHDL::Ast.type_mark(type)
      end
      include RbVHDL::Ast::Interface::Methods::FunctionParameter
    end

    class PureFunctionDecl   < FunctionDecl
    end

    class ImpureFunctionDecl < FunctionDecl
    end

    class PureFunctionBody   < FunctionBody
    end

    class ImpureFunctionBody < FunctionBody
    end
  end

  def self.procedure_declaration(owner, ident)
    identifier = RbVHDL::Ast.identifier(ident)
    return RbVHDL::Ast::Declaration::ProcedureDecl.new(owner, identifier)
  end

  def self.procedure_body(owner, ident)
    identifier = RbVHDL::Ast.identifier(ident)
    return RbVHDL::Ast::Declaration::ProcedureBody.new(owner, identifier)
  end

  def self.function_identifier(ident)
    if ident.class == RbVHDL::Ast::Expression::OperatorSymbol then
      return ident
    else
      return RbVHDL::Ast.identifier(ident)
    end
  end

  def self.function_declaration(owner, ident, type)
    identifier = RbVHDL::Ast.function_identifier(ident)
    type_mark  = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Declaration::FunctionDecl.new(owner, identifier, type_mark)
  end
    
  def self.function_body(owner, ident, type)
    identifier = RbVHDL::Ast.function_identifier(ident)
    type_mark  = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Declaration::FunctionBody.new(owner, identifier, type_mark)
  end
    
  def self.pure_function_declaration(owner, ident, type)
    identifier = RbVHDL::Ast.function_identifier(ident)
    type_mark  = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Declaration::PureFunctionDecl.new(owner, identifier, type_mark)
  end
    
  def self.pure_function_body(owner, ident, type)
    identifier = RbVHDL::Ast.function_identifier(ident)
    type_mark  = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Declaration::PureFunctionBody.new(owner, identifier, type_mark)
  end
    
  def self.impure_function_declaration(owner, ident, type)
    identifier = RbVHDL::Ast.function_identifier(ident)
    type_mark  = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Declaration::ImpureFunctionDecl.new(owner, identifier, type_mark)
  end
    
  def self.impure_function_body(owner, ident, type)
    identifier = RbVHDL::Ast.function_identifier(ident)
    type_mark  = RbVHDL::Ast.type_mark(type)
    return RbVHDL::Ast::Declaration::ImpureFunctionBody.new(owner, identifier, type_mark)
  end
    
end
