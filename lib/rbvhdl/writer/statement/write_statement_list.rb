module RbVHDL::Writer
  module Statement

    WRITE_DIRECTIVE = {
      :statement_indent => "    ",
      :target_align     => true,
    }

    module WriteStatementList

      def _target_field_max_size
        if @_statement_list.size > 0 then
          return @_statement_list.map { |statement|
            if statement.class::WRITE_DIRECTIVE.fetch(:target_align_enable, false) then
              statement._target._write_string.size
            else
              0
            end
          }.max
        else
          return 0
        end
      end

      def _write_statement_list(directive={})
        write_line = []
        if @_statement_list.size > 0 then
          indent           = directive.fetch(:indent          , "" )
          target_format    = directive.fetch(:target_format   , nil)
          target_align     = directive.fetch(:target_align    , self.class::WRITE_DIRECTIVE[:target_align    ])
          statement_indent = directive.fetch(:statement_indent, self.class::WRITE_DIRECTIVE[:statement_indent])

          statement_directive = directive.clone
          statement_directive[:indent] = indent + statement_indent
          statement_directive.delete(:target_format)

          if target_align == true then
            target_align_directive = statement_directive.dup
            if target_format.nil? then
              target_field_max_size = _target_field_max_size
              if target_field_max_size > 0 then
                target_align_directive[:target_format] = "%<target>-#{target_field_max_size+1}s"
              else
                target_align_directive[:target_format] = "%{target} "
              end
            else
                target_align_directive[:target_format] = target_format
            end
            @_statement_list.each do |stmt|
              if stmt.class::WRITE_DIRECTIVE.fetch(:target_align_enable, false) then
                write_line.concat(stmt._write_line(target_align_directive))
              else
                write_line.concat(stmt._write_line(statement_directive))
              end
            end
          else
            @_statement_list.each do |stmt|
              write_line.concat(stmt._write_line(statement_directive))
            end
          end
        end
        return write_line
      end

    end

  end
end
