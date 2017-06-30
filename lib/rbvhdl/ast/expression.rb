module RbVHDL::Ast

  class Expression
    attr_reader   :_annotation
    def initialize
      @_annotation = Hash.new
    end
  end

  require_relative 'expression/logical_expression'
  require_relative 'expression/relation'
  require_relative 'expression/shift_expression'
  require_relative 'expression/simple_expression'
  require_relative 'expression/term'
  require_relative 'expression/factor'
  require_relative 'expression/primary'
  require_relative 'expression/literal'
  require_relative 'expression/name'
  require_relative 'expression/choices'
  require_relative 'expression/aggregate'
  require_relative 'expression/typemark'
  require_relative 'expression/parenthesized_expression'
  require_relative 'expression/qualified_expression'
  require_relative 'expression/operation'
  require_relative 'expression/signature'

  def self.expression(arg)
    if    arg.class < RbVHDL::Ast::Expression then
      return arg
    elsif arg.class < Integer or arg.class == Float then
      return self.numeric_expression(arg)
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{arg.inspect}:#{arg.class})"
    end      
  end

  def self.expression_or_nil(arg)
    return (arg.nil?)? nil : self.expression(arg)
  end
end
