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

      def initialize(owner, name, &block)
        @_owner                      = owner
        @_label                      = nil
        @_postponed                  = nil
        @_name                       = name
        @_parameter_association_list = []
        @_annotation                 = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      def _label!(label, &block)
        @_label = RbVHDL::Ast.label_or_nil(label)
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      def _postponed!(&block)
        @_postponed = true
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      include RbVHDL::Ast::Association::Methods::Parameter
    end

  end

  def self.procedure_call(owner, name, &block)
    return RbVHDL::Ast::Statement::ProcedureCall.new(owner, RbVHDL::Ast.name(name), &block)
  end

end
