require_relative '../association/methods'

module RbVHDL::Ast

  module Statement

    class ProcedureCall
      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_postponed
      attr_reader   :_name
      attr_reader   :_parameter_association_list
      attr_reader   :_annotation

      def initialize(owner, name)
        @_owner                      = owner
        @_label                      = nil
        @_postponed                  = nil
        @_name                       = name
        @_parameter_association_list = []
        @_annotation                 = Hash.new
      end

      def _label!(label)
        @_label = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _postponed!
        @_postponed = true
        return self
      end

      include RbVHDL::Ast::Association::Methods::Parameter
    end

  end

  def self.procedure_call(owner, name)
    return RbVHDL::Ast::Statement::ProcedureCall.new(owner, RbVHDL::Ast.name(name))
  end

end
