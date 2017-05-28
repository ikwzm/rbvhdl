module RbVHDL::Ast

  module Statement

    class Wait
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_signal_list
      attr_accessor :_condition
      attr_accessor :_expression

      def initialize(owner)
        @_owner       = owner
        @_label       = nil
        @_signal_list = []
        @_condition   = nil
        @_expression  = nil
      end

      def _label!(label)
        @_label       = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _on!(*signals)
        signals.each do |signal|
          @_signal_list.push(RbVHDL::Ast.name(signal))
        end
        return self
      end

      def _until!(condition)
        @_condition   = RbVHDL::Ast.expression_or_nil(condition)
        return self
      end

      def _for!(expression)
        @_expression  = RbVHDL::Ast.expression_or_nil(expression)
        return self
      end
    end

  end

  def self.wait_statement(owner)
    return RbVHDL::Ast::Statement::Wait.new(owner)
  end

end
