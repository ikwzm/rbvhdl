module RbVHDL::Writer

  module Association

    module Port

      module WriteAssociation

        def _write_port_association(directive={})
          write_line = []
          @_port_association_list.each do |assoc|
            write_line.concat(assoc._write_line(directive))
          end
          return write_line
        end

      end
    end
  end
end
