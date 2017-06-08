module RbVHDL::Ast

  class DesignUnit
    RbVHDL::Writer._write_directive(self, {:clause_indent => "", :unit_indent => ""})
    
    def _write_line(directive={})
      write_line       = []
      indent           = directive.fetch(:indent, "")

      clause_indent    = directive.fetch(:clause_indent, self.class._write_directive[:clause_indent])
      clause_directive = directive.dup
      clause_directive[:indent] = indent + clause_indent
      @_clause_list.each do |clause|
        write_line.concat(clause._write_line(clause_directive))
      end

      unit_indent    = directive.fetch(:unit_indent, self.class._write_directive[:unit_indent])
      unit_directive = directive.dup
      unit_directive[:indent] = indent + unit_indent
      @_unit_list.each do |unit|
        write_line.concat(unit._write_line(unit_directive))
      end
      return write_line
    end
  end
  
end

