module RbVHDL::Writer

  module Association

    module Generic

      module WriteAssociation

        def _write_generic_association(directive={})
          write_line = []
          @_generic_association_list.each do |assoc|
            write_line.concat(assoc._write_line(directive))
          end
          return write_line
        end

      end
    end
  end
end

      
