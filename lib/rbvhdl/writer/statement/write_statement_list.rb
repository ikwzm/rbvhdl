module RbVHDL::Writer
  module Statement

    WRITE_DIRECTIVE = {
      :statement_indent => "    ",
      :target_align     => true,
    }

    module WriteStatementList

      def _write_statement_list(directive={})
        write_line = []
        if @_statement_list.size > 0 then
          indent           = directive.fetch(:indent, "")
          target_align     = directive.fetch(:target_align    , self.class::WRITE_DIRECTIVE[:target_align    ])
          statement_indent = directive.fetch(:statement_indent, self.class::WRITE_DIRECTIVE[:statement_indent])

          statement_directive = directive.clone
          statement_directive[:indent] = indent + statement_indent

          if target_align == true then
            target_max_size = @_statement_list.map{|stmt|
              if stmt.class::WRITE_DIRECTIVE.fetch(:target_align, false) and stmt.class::WRITE_DIRECTIVE.fetch(:target_format, false) then
                stmt._target._write_string.size
              else
                0
              end
            }.max
            target_align_directive = statement_directive.dup
            target_align_directive[:target_format] = "%<target>-#{target_max_size+1}s"
            @_statement_list.each do |stmt|
              if stmt.class::WRITE_DIRECTIVE.fetch(:target_align, false) and stmt.class::WRITE_DIRECTIVE.fetch(:target_format, false) then
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
