module RbVHDL::Ast

  class DesignUnit
    attr_reader   :_clause_list
    attr_reader   :_unit_list
    attr_reader   :_annotation
    
    def initialize
      @_clause_list = []
      @_unit_list   = []
      @_annotation  = Hash.new
    end

    def _library_clause(identifier)
      clause = RbVHDL::Ast.library_clause(self, identifier)
      @_clause_list.push(clause)
      return clause
    end

    def _use_clause(args=nil)
      clause = RbVHDL::Ast.use_clause(self, args)
      @_clause_list.push(clause)
      return clause
    end

    def _entity(identifier)
      unit = RbVHDL::Ast.entity_declaration(self, identifier)
      @_unit_list.push(unit)
      return unit
    end

    def _architecture(identifier, entity_name)
      unit = RbVHDL::Ast.architecture_body(self, identifier, entity_name)
      @_unit_list.push(unit)
      return unit
    end

    def _package(identifier)
      unit = RbVHDL::Ast.package_declaration(self, identifier)
      @_unit_list.push(unit)
      return unit
    end

    def _package_body(identifier)
      unit = RbVHDL::Ast.package_body(self, identifier)
      @_unit_list.push(unit)
      return unit
    end

    def _configuration(identifier, entity_name)
      unit = RbVHDL::Ast.configuration_declaration(self, identifier, entity_name)
      @_unit_list.push(unit)
      return unit
    end
    
  end
end
