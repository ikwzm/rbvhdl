module RbVHDL::Writer
  module Declaration
    module Methods

      def _write_declaration(directive={})
        write_line = []
        if @_declarative_item_list.size > 0 then
          @_declarative_item_list.each do |item|
            write_line.concat(item._write_line(directive))
          end
        end
        return write_line
      end

    end
  end
end
