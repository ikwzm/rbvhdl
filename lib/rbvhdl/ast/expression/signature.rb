module RbVHDL::Ast

  class Expression

    class Signature
      attr_reader   :_parameter_type_list
      attr_reader   :_return_type

      def initialize
        @_parameter_type_list = []
        @_return_type         = nil
      end

      def _parameter!(*types)
        types.each do |type|
          @_parameter_type_list.push(RbVHDL::Ast.type_mark(type))
        end
        return self
      end

      def _return!(type)
        @_return_type = RbVHDL::Ast.type_mark(type)
        return self
      end
    end
  end

  def self.signature(*param_types)
    return RbVHDL::Ast::Expression::Signature.new._parameter!(*param_types)
  end

end
