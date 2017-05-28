require_relative 'primary'

module RbVHDL::Ast

  class Expression

    class TypeMark < Primary
      attr_reader   :_name
      attr_reader   :_expr
      def initialize(name, expr)
        super()
        @_name = name
        @_expr = expr
      end
    end

  end

end
