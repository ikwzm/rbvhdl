module RbVHDL::Writer

  RbVHDL::Ast::Expression.constants.collect{|name| RbVHDL::Ast::Expression.const_get(name)}.select{|expr| expr.const_defined?(:OPERATOR)}.each do |klass|
    operator = klass.const_get(:OPERATOR)
    op_type  = klass.const_get(:TYPE )
    if    op_type == :binary or op_type == :polynomial then
      if operator =~ /[a-zA-Z=<>&]+/ then
        write_directive = {:format => "%{left} %{operator} %{right}"}
      else
        write_directive = {:format => "%{left}%{operator}%{right}"  }
      end
      write_directive[:operator      ] = operator
      write_directive[:reserved_words] = RbVHDL::Writer::RESERVED_WORDS
      klass.const_set(:WRITE_DIRECTIVE, write_directive)
      klass.class_eval do
        def _write_string(directive={})
          format         = directive.fetch(:format        , self.class::WRITE_DIRECTIVE[:format        ])
          operator       = directive.fetch(:operator      , self.class::WRITE_DIRECTIVE[:operator      ])
          reserved_words = directive.fetch(:reserved_words, self.class::WRITE_DIRECTIVE[:reserved_words])
          left           = @_operand[0]._write_string
          right          = @_operand[1]._write_string
          return format % {operator: reserved_words[operator], left: left, right: right}
        end
      end
    elsif op_type == :unary then
      if operator =~ /[a-zA-Z=<>&]+/ then
        write_directive = {:format => "%{operator} %{operand}"}
      else
        write_directive = {:format => "%{operator}%{operand}"}
      end
      write_directive[:operator      ] = operator
      write_directive[:reserved_words] = RbVHDL::Writer::RESERVED_WORDS
      klass.const_set(:WRITE_DIRECTIVE, write_directive)
      klass.class_eval do
        def _write_string(directive={})
          format         = directive.fetch(:format        , self.class::WRITE_DIRECTIVE[:format        ])
          operator       = directive.fetch(:operator      , self.class::WRITE_DIRECTIVE[:operator      ])
          reserved_words = directive.fetch(:reserved_words, self.class::WRITE_DIRECTIVE[:reserved_words])
          operand        = @_operand[0]._write_string
          return format % {operator: reserved_words[operator], operand: operand}
        end
      end
    end
  end
end
