module RbVHDL::Ast
  module Statement
    module Methods

      module Assertion
        def _assertion_statement(condition)
          stmt = RbVHDL::Ast.assertion_statement(self, condition)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Block
        def _block_statement(label)
          stmt = RbVHDL::Ast.block_statement(self, label)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Case
        def _case_statement(expression)
          stmt = RbVHDL::Ast.case_statement(self, expression)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module ComponentInstantiation
        def _component_instantiation_statement(label, component_name)
          stmt = RbVHDL::Ast.component_instantiation_statement(self, label, component_name)
          @_statement_list.push(stmt)
          return stmt
        end
        def _entity_instantiation_statement(label, entity_name, architecture_name)
          stmt = RbVHDL::Ast.entity_instantiation_statement(self, label, entity_name, architecture_name)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Generate
        def _if_generate_statement(label, condition)
          stmt = RbVHDL::Ast.if_generate_statement(self, label, condition)
          @_statement_list.push(stmt)
          return stmt
        end
        def _for_generate_statement(label, index_identifier, index_range)
          stmt = RbVHDL::Ast.for_generate_statement(self, label, index_identifier, index_range)
          @_statement_list.push(stmt)
          return stmt
        end
      end
  
      module If
        def _if_statement(condition)
          stmt = RbVHDL::Ast.if_statement(self, condition)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Loop
        def _loop_statement
          stmt = RbVHDL::Ast.loop_statement(self)
          @_statement_list.push(stmt)
          return stmt
        end
        def _for_loop_statement(index_identifier, index_range)
          stmt = RbVHDL::Ast.for_loop_statement(self, index_identifier, index_range)
          @_statement_list.push(stmt)
          return stmt
        end
        def _while_loop_statement(condition)
          stmt = RbVHDL::Ast.while_loop_statement(self, condition)
          @_statement_list.push(stmt)
          return stmt
        end
        def _next_statement
          stmt = RbVHDL::Ast.next_statement(self)
          @_statement_list.push(stmt)
          return stmt
        end
        def _exit_statement
          stmt = RbVHDL::Ast.exit_statement(self)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Null
        def _null_statement
          stmt = RbVHDL::Ast.null_statement(self)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Process
        def _process_statement
          stmt = RbVHDL::Ast.process_statement(self)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module ProcedureCall
        def _procedure_call(name)
          stmt = RbVHDL::Ast.procedure_call(self, name)
          @_statement_list.push(stmt)
          return stmt
        end
      end
  
      module Report
        def _report_statement(expression)
          stmt = RbVHDL::Ast.report_statement(self, expression)
          @_statement_list.push(stmt)
          return stmt
        end
      end      
  
      module Return
        def _return_statement(expression=nil)
          stmt = RbVHDL::Ast.return_statement(self, expression)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module SignalAssignment
        def _signal_assignment_statement(target, waveform=nil)
          stmt = RbVHDL::Ast.signal_assignment_statement(self, target, waveform)
          @_statement_list.push(stmt)
          return stmt
        end
        def _simple_signal_assignment_statement(target, waveform=nil)
          stmt = RbVHDL::Ast.simple_signal_assignment_statement(self, target, waveform)
          @_statement_list.push(stmt)
          return stmt
        end
        def _conditional_signal_assignment_statement(target, waveform=nil)
          stmt = RbVHDL::Ast.conditional_signal_assignment_statement(self, target, waveform)
          @_statement_list.push(stmt)
          return stmt
        end
        def _selected_signal_assignment_statement(expression, target, waveform=nil, choices=nil)
          stmt = RbVHDL::Ast.selected_signal_assignment_statement(self, expression, target, waveform, choices)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module VariableAssignment
        def _variable_assignment_statement(target, value=nil)
          stmt = RbVHDL::Ast.variable_assignment_statement(self, target, value)
          @_statement_list.push(stmt)
          return stmt
        end
        def _simple_variable_assignment_statement(target, value=nil)
          stmt = RbVHDL::Ast.simple_variable_assignment_statement(self, target, value)
          @_statement_list.push(stmt)
          return stmt
        end
        def _conditional_variable_assignment_statement(target, value=nil)
          stmt = RbVHDL::Ast.conditional_variable_assignment_statement(self, target, value)
          @_statement_list.push(stmt)
          return stmt
        end
        def _selected_variable_assignment_statement(expression, target, value=nil, choices=nil)
          stmt = RbVHDL::Ast.selected_variable_assignment_statement(self, expression, target, value, choices)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Wait
        def _wait_statement
          stmt = RbVHDL::Ast.wait_statement(self)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Concurrent
        include Block
        include Process
        include ProcedureCall
        include Assertion
        include SignalAssignment
        include ComponentInstantiation
        include Generate
      end

      module Sequential
        include Wait
        include Assertion
        include Report
        include SignalAssignment
        include VariableAssignment
        include ProcedureCall
        include If
        include Case
        include Loop
        include Return
        include Null
      end

    end
  end
end
