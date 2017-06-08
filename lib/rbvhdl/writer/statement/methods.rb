module RbVHDL::Writer
  module Statement
    module Methods

      def _write_statement(directive={})
        write_line = []
        if @_statement_list.size > 0 then
          @_statement_list.each do |item|
            write_line.concat(item._write_line(directive))
          end
        end
        return write_line
      end

    end
  end
end
