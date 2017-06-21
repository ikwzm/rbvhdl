module RbVHDL::Writer
  module Statement

    WRITE_DIRECTIVE = {
      :statement_indent => "    ",
    }

    module WriteStatementList

      def _write_statement_list(directive={})
        write_line = []
        if @_statement_list.size > 0 then
          @_statement_list.each do |item|
            indent           = directive.fetch(:indent, "")
            statement_indent = directive.fetch(:statement_indent, self.class::WRITE_DIRECTIVE[:statement_indent])

            statement_directive = directive.clone
            statement_directive[:indent] = indent + statement_indent
              
            write_line.concat(item._write_line(statement_directive))
          end
        end
        return write_line
      end

    end

  end
end
