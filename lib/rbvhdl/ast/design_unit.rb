module RbVHDL::Ast

  class DesignUnit
    attr_reader   :_unit_list
    attr_reader   :_annotation
    
    def initialize(&block)
      @_unit_list   = []
      @_annotation  = Hash.new
      if block_given? then
        self.instance_eval(&block)
      end
    end

    def _horizontal_rule
      unit = RbVHDL::Ast.horizontal_rule(self)
      @_unit_list.push(unit)
      return unit
    end

    def _new_line
      unit = RbVHDL::Ast.new_line(self)
      @_unit_list.push(unit)
      return unit
    end

    def _comment(text)
      unit = RbVHDL::Ast.comment(self, text)
      @_unit_list.push(unit)
      return unit
    end

    def _library_clause(identifier)
      unit = RbVHDL::Ast.library_clause(self, identifier)
      @_unit_list.push(unit)
      return unit
    end

    def _use_clause(args=nil)
      unit = RbVHDL::Ast.use_clause(self, args)
      @_unit_list.push(unit)
      return unit
    end

    def _entity(identifier, &block)
      unit = RbVHDL::Ast.entity_declaration(self, identifier, &block)
      @_unit_list.push(unit)
      return unit
    end

    def _architecture(identifier, entity_name, &block)
      unit = RbVHDL::Ast.architecture_body(self, identifier, entity_name, &block)
      @_unit_list.push(unit)
      return unit
    end

    def _package(identifier, &block)
      unit = RbVHDL::Ast.package_declaration(self, identifier, &block)
      @_unit_list.push(unit)
      return unit
    end

    def _package_body(identifier, &block)
      unit = RbVHDL::Ast.package_body(self, identifier, &block)
      @_unit_list.push(unit)
      return unit
    end

    def _configuration(identifier, entity_name, &block)
      unit = RbVHDL::Ast.configuration_declaration(self, identifier, entity_name, &block)
      @_unit_list.push(unit)
      return unit
    end
    
  end
end
