module RbVHDL::Ast
  module Declaration
    module Methods

      module Type

        def _integer_type_declaration(identifier, range)
          decl = RbVHDL::Ast.integer_type_declaration(self, identifier, range)
          @_declarative_item_list.push(decl)
          return decl
        end

        def _floating_type_declaration(identifier, range)
          decl = RbVHDL::Ast.floating_type_declaration(self, identifier, range)
          @_declarative_item_list.push(decl)
          return decl
        end

        def _physical_type_declaration(identifier, range, pyhsical_identifier, unit_list=nil)
          decl = RbVHDL::Ast.physical_type_declaration(self, identifier, range, pyhsical_identifier, unit_list)
          @_declarative_item_list.push(decl)
          return decl
        end

        def _array_type_declaration(identifier, range, type)
          decl = RbVHDL::Ast.array_type_declaration(self, identifier, range, type)
          @_declarative_item_list.push(decl)
          return decl
        end

        def _enumeration_type_declaration(identifier, enum_list=nil)
          decl = RbVHDL::Ast.enumeration_type_declaration(self, identifier, enum_list)
          @_declarative_item_list.push(decl)
          return decl
        end

        def _record_type_declaration(identifier, record=nil)
          decl = RbVHDL::Ast.record_type_declaration(self, identifier, record)
          @_declarative_item_list.push(decl)
          return decl
        end

        def _file_type_declaration(identifier, type)
          decl = RbVHDL::Ast.file_type_declaration(self, identifier, type)
          @_declarative_item_list.push(decl)
          return decl
        end
        
        def _access_type_declaration(identifier, type)
          decl = RbVHDL::Ast.access_type_declaration(self, identifier, type)
          @_declarative_item_list.push(decl)
          return decl
        end

      end

      module Subtype
        def _subtype_declaration(identifier, type)
          decl = RbVHDL::Ast.subtype_declaration(self, identifier, type)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module Constant
        def _constant_declaration(identifier, type, value=nil)
          decl = RbVHDL::Ast.constant_declaration(self, identifier, type, value)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module Variable
        def _variable_declaration(identifier, type, value=nil)
          decl = RbVHDL::Ast.variable_declaration(self, identifier, type, value)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module Signal
        def _signal_declaration(identifier, type, value=nil, mode=nil)
          decl = RbVHDL::Ast.signal_declaration(self, identifier, type, value, mode)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module Alias
        def _alias_declaration(identifier, type, name, signature=nil)
          decl = RbVHDL::Ast.alias_declaration(self, identifier, type, name, signature)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module File
        def _file_declaration(identifier, type, open=nil, string=nil)
          decl = RbVHDL::Ast.file_declaration(self, identifier, type, open, string)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module AttributeDecl
        def _attribute_declaration(identifier, type)
          decl = RbVHDL::Ast.attribute_declaration(self, identifier, type)
          @_declarative_item_list.push(decl)
          return decl
        end
      end
    
      module AttributeSpec
        def _attribute_specification(identifier, entity_name_list, entity_class, value)
          decl = RbVHDL::Ast.attribute_specification(self, identifier, entity_name_list, entity_class, value)
          @_declarative_item_list.push(decl)
          return decl
        end
      end
    
      module Component
        def _component_declaration(identifier)
          decl = RbVHDL::Ast.component_declaration(self, identifier)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module SubProgramDecl
        def _procedure_declaration(identifier)
          decl = RbVHDL::Ast.procedure_declaration(self, identifier)
          @_declarative_item_list.push(decl)
          return decl
        end
        def _function_declaration(identifier, type_mark)
          decl = RbVHDL::Ast.function_declaration(self, identifier, type_mark)
          @_declarative_item_list.push(decl)
          return decl
        end
        def _pure_function_declaration(identifier, type_mark)
          decl = RbVHDL::Ast.pure_function_declaration(self, identifier, type_mark)
          @_declarative_item_list.push(decl)
          return decl
        end
        def _impure_function_declaration(identifier, type_mark)
          decl = RbVHDL::Ast.impure_function_declaration(self, identifier, type_mark)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module SubProgramBody
        def _procedure_body(identifier)
          decl = RbVHDL::Ast.procedure_body(self, identifier)
          @_declarative_item_list.push(decl)
          return decl
        end
        def _function_body(identifier, type_mark)
          decl = RbVHDL::Ast.function_body(self, identifier, type_mark)
          @_declarative_item_list.push(decl)
          return decl
        end
        def _pure_function_body(identifier, type_mark)
          decl = RbVHDL::Ast.pure_function_body(self, identifier, type_mark)
          @_declarative_item_list.push(decl)
          return decl
        end
        def _impure_function_body(identifier, type_mark)
          decl = RbVHDL::Ast.impure_function_body(self, identifier, type_mark)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module UseClause
        def _use_clause(name_list=nil)
          decl = RbVHDL::Ast.use_clause(self, name_list)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module GroupTemplate
        def _group_template_declaration(identifier, entity_class_list=[])
          decl = RbVHDL::Ast.group_template_declaration(self, identifier, entity_class_list)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module Group
        def _group_declaration(identifier, template_name, name_list=[])
          decl = RbVHDL::Ast.group_declaration(self, identifier, template_name, name_list)
          @_declarative_item_list.push(decl)
          return decl
        end
      end

      module BlockItem
        include SubProgramDecl
        include SubProgramBody
        include Type
        include Subtype
        include Constant
        include Variable
        include Signal
        include Alias
        include File
        include Component
        include AttributeDecl
        include AttributeSpec
        include UseClause
        include GroupTemplate
        include Group
      end

      module SubProgramItem
        include SubProgramDecl
        include SubProgramBody
        include Type
        include Subtype
        include Constant
        include Variable
        include Signal
        include Alias
        include File
        include AttributeDecl
        include AttributeSpec
        include UseClause
        include GroupTemplate
        include Group
      end
    
      module PackageItem
        include SubProgramDecl
        include Type
        include Subtype
        include Constant
        include Variable
        include Signal
        include Alias
        include File
        include Component
        include AttributeDecl
        include AttributeSpec
        include UseClause
        include GroupTemplate
        include Group
      end
    
      module PackageBodyItem
        include SubProgramDecl
        include SubProgramBody
        include Type
        include Subtype
        include Constant
        include Variable
        include Signal
        include Alias
        include File
        include UseClause
        include GroupTemplate
        include Group
      end

      module EntityItem
        include SubProgramDecl
        include SubProgramBody
        include Type
        include Subtype
        include Constant
        include Variable
        include Signal
        include Alias
        include File
        include AttributeDecl
        include AttributeSpec
        include UseClause
        include GroupTemplate
        include Group
      end

      module ProcessItem
        include SubProgramDecl
        include SubProgramBody
        include Type
        include Subtype
        include Constant
        include Variable
        include Signal
        include Alias
        include File
        include AttributeDecl
        include AttributeSpec
        include UseClause
        include GroupTemplate
        include Group
      end

    end
  end
end
