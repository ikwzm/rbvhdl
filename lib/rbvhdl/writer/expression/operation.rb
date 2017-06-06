module RbVHDL::Writer

  RbVHDL::Ast::Expression.constants.collect{|name| RbVHDL::Ast::Expression.const_get(name)}.select{|expr| expr.const_defined?(:OPERATOR)}.each do |klass|
    operator = klass.const_get(:OPERATOR)
    op_type  = klass.const_get(:TYPE )
    if    op_type == :binary or op_type == :polynomial then
      if operator =~ /[a-zA-Z=<>&]+/ then
        klass.instance_variable_set(:@_write_directive, {:format => "%{left} %{operator} %{right}", :operator => operator})
      else
        klass.instance_variable_set(:@_write_directive, {:format => "%{left}%{operator}%{right}"  , :operator => operator})
      end
      klass.class_eval do
        def self._write_directive
          return @_write_directive
        end
        def _write_string(directive={})
          format   = directive.fetch(:format   , self.class._write_directive[:format  ])
          operator = directive.fetch(:operator , self.class._write_directive[:operator])
          left     = @_operand[0]._write_string
          right    = @_operand[1]._write_string
          return format % {operator: operator, left: left, right: right}
        end
      end
    elsif op_type == :unary then
      if operator =~ /[a-zA-Z=<>&]+/ then
        klass.instance_variable_set(:@_write_directive, {:format => "%{operator} %{operand}", :operator => operator})
      else
        klass.instance_variable_set(:@_write_directive, {:format => "%{operator}%{operand}" , :operator => operator})
      end
      klass.class_eval do
        def self._write_directive
          return @_write_directive
        end
        def _write_string(directive={})
          format   = directive.fetch(:format   , self.class._write_directive[:format  ])
          operator = directive.fetch(:operator , self.class._write_directive[:operator])
          operand  = @_operand[0]._write_string
          return format % {operator: operator, operand: operand}
        end
      end
    end
  end
end
