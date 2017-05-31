module RbVHDL::Ast
  module Interface
    module Methods

      module Generic
        def _generic_interface(identifier, type, value=nil)
          interface = RbVHDL::Ast.interface_constant_declaration(self, identifier, type, nil, value)
          @_generic_interface_list.push(interface)
          return interface
        end
      end

      module Port
        def _port_interface(identifier, type, mode=nil, value=nil)
          interface = RbVHDL::Ast.interface_signal_declaration(self, identifier, type, mode, value)
          @_port_interface_list.push(interface)
          return interface
        end
      end

      module ProcedureParameter

        def _parameter_interface(identifier, type, mode=nil, value=nil)
          interface = RbVHDL::Ast.interface_variable_declaration(self, identifier, type, mode, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_variable_interface(identifier, type, mode=nil, value=nil)
          interface = RbVHDL::Ast.interface_variable_declaration(self, identifier, type, mode, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_signal_interface(identifier, type, mode=nil, value=nil)
          interface = RbVHDL::Ast.interface_signal_declaration(self, identifier, type, mode, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_constant_interface(identifier, type, mode=nil, value=nil)
          interface = RbVHDL::Ast.interface_constant_declaration(self, identifier, type, mode, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_file_interface(identifier, type)
          interface = RbVHDL::Ast.interface_file_declaration(self, identifier, type)
          @_parameter_interface_list.push(interface)
          return interface
        end
      end

      module FunctionParameter

        def _parameter_interface(identifier, type, value=nil)
          interface = RbVHDL::Ast.interface_variable_declaration(self, identifier, type, nil, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_variable_interface(identifier, type, value=nil)
          interface = RbVHDL::Ast.interface_variable_declaration(self, identifier, type, nil, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_signal_interface(identifier, type, value=nil)
          interface = RbVHDL::Ast.interface_signal_declaration(self, identifier, type, nil, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_constant_interface(identifier, type, value=nil)
          interface = RbVHDL::Ast.interface_constant_declaration(self, identifier, type, nil, value)
          @_parameter_interface_list.push(interface)
          return interface
        end

        def _parameter_file_interface(identifier, type)
          interface = RbVHDL::Ast.interface_file_declaration(self, identifier, type)
          @_parameter_interface_list.push(interface)
          return interface
        end

      end
    end
  end
end
