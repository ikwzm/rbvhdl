require_relative 'primary'
require_relative 'aggregate'

module RbVHDL::Ast

  class Expression
    # qualified_expression  : type_mark "'" "(" expression ")"
    #                       | type_mark "'" aggregate
    class QualifiedExpression < Primary
      attr_reader   :_type_mark
      attr_reader   :_argument
      def initialize(type_mark, argument)
        super()
        @_type_mark = type_mark
        @_argument  = argument
      end
    end

    class NewQualifiedExpression < QualifiedExpression
    end

  end

  def self.qualified_expression(name, arg)
    type_mark = self.name(name)
    argument  = self.expression(arg)
    return RbVHDL::Ast::Expression::QualifiedExpression.new(type_mark, argument)
  end

  def self.new_qualified_expression(name, arg)
    type_mark = self.name(name)
    argument  = self.expression(arg)
    return RbVHDL::Ast::Expression::NewQualifiedExpression.new(type_mark, argument)
  end

end
