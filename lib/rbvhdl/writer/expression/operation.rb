module RbVHDL::Writer

  RbVHDL::Ast::Expression.constants.collect{|name| RbVHDL::Ast::Expression.const_get(name)}.select{|expr| expr.const_defined?(:OPERATOR)}.each do |klass|
    operator = klass.const_get(:OPERATOR)
    op_type  = klass.const_get(:TYPE )
    if    op_type == :binary or op_type == :polynomial then
      if operator =~ /[a-zA-Z=<>&]+/ then
        klass.const_set(:WRITE_DIRECTIVE, {:format => "%{left} %{operator} %{right}", :operator => operator})
      else
        klass.const_set(:WRITE_DIRECTIVE, {:format => "%{left}%{operator}%{right}"  , :operator => operator})
      end
      klass.class_eval do
        def _write_string(directive={})
          format   = directive.fetch(:format   , self.class::WRITE_DIRECTIVE[:format  ])
          operator = directive.fetch(:operator , self.class::WRITE_DIRECTIVE[:operator])
          left     = @_operand[0]._write_string
          right    = @_operand[1]._write_string
          return format % {operator: operator, left: left, right: right}
        end
      end
    elsif op_type == :unary then
      if operator =~ /[a-zA-Z=<>&]+/ then
        klass.const_set(:WRITE_DIRECTIVE, {:format => "%{operator} %{operand}", :operator => operator})
      else
        klass.const_set(:WRITE_DIRECTIVE, {:format => "%{operator}%{operand}" , :operator => operator})
      end
      klass.class_eval do
        def _write_string(directive={})
          format   = directive.fetch(:format   , self.class::WRITE_DIRECTIVE[:format  ])
          operator = directive.fetch(:operator , self.class::WRITE_DIRECTIVE[:operator])
          operand  = @_operand[0]._write_string
          return format % {operator: operator, operand: operand}
        end
      end
    end
  end
end
