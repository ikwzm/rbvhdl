module RbVHDL::Ast

  class DesignUnit
    WRITE_DIRECTIVE = {:clause_indent => "", :unit_indent => ""}
    
    def _write_line(directive={})
      write_line = []
      indent    = directive.fetch(:indent, "")

      comment_directive = directive.dup

      clause_indent     = directive.fetch(:clause_indent, WRITE_DIRECTIVE[:clause_indent])
      clause_directive  = directive.dup
      clause_directive[:indent] = indent + clause_indent

      unit_indent       = directive.fetch(:unit_indent  , WRITE_DIRECTIVE[:unit_indent  ])
      unit_directive    = directive.dup
      unit_directive[:indent]   = indent + unit_indent

      @_unit_list.each do |unit|
        if    unit.class <= RbVHDL::Ast::Comment then
          write_line.concat(unit._write_line(comment_directive))
        elsif unit.class == RbVHDL::Ast::LibraryClause or
              unit.class == RbVHDL::Ast::Declaration::UseClause then
          write_line.concat(unit._write_line(clause_directive))
        else
          write_line.concat(unit._write_line(unit_directive))
        end
      end
      return write_line
    end
  end
  
end

