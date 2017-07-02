module RbVHDL::Writer

  module Declaration

    module Methods

      module DeclarativeItemList
        def _write_declarative_item_list(directive={})
          write_line = []
          if @_declarative_item_list.size > 0 then
            indent                = directive.fetch(:indent, "")
            declaration_indent    = directive.fetch(:declaration_indent          , self.class::WRITE_DIRECTIVE[:declaration_indent])
            identifier_align      = directive.fetch(:declaration_identifier_align, self.class::WRITE_DIRECTIVE[:declaration_identifier_align])

            declaration_directive = directive.clone
            declaration_directive[:indent] = indent + declaration_indent

            if identifier_align == true then
              identifier_field_max_size  = 0
              type_field_max_size        = 0
              @_declarative_item_list.each do |decl|
                if decl.class::WRITE_DIRECTIVE.fetch(:identifier_align, nil) == true then
                  identifier_field_size     = decl._write_identifier_string.size
                  identifier_field_max_size = identifier_field_size if(identifier_field_size > identifier_field_max_size)
                end
              end
              identifier_aligned_directive = declaration_directive.dup
              identifier_aligned_directive[:identifier_format] = "%<identifier>-#{((((identifier_field_max_size+1).to_f/8).ceil)*8)-1}s"
            end
  
            @_declarative_item_list.each do |decl|
              if identifier_align == true and decl.class::WRITE_DIRECTIVE.fetch(:identifier_align, nil) == true then
                write_line.concat(decl._write_line(identifier_aligned_directive))
              else
                write_line.concat(decl._write_line(declaration_directive))
              end
            end
          end
          return write_line
        end
      end
    end
  end
end
