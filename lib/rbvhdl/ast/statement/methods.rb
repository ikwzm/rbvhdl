module RbVHDL::Ast
  module Statement
    module Methods

      module Comment
        def _statement_horizontal_rule
          decl = RbVHDL::Ast.horizontal_rule(self)
          @_statement_list.push(decl)
          return decl
        end
        def _statement_new_line
          decl = RbVHDL::Ast.new_line(self)
          @_statement_list.push(decl)
          return decl
        end
        def _statement_comment(text)
          decl = RbVHDL::Ast.comment(self, text)
          @_statement_list.push(decl)
          return decl
        end
      end

      module Assertion
        def _assertion_statement(condition)
          stmt = RbVHDL::Ast.assertion_statement(self, condition)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Block
        def _block_statement(label, &block)
          stmt = RbVHDL::Ast.block_statement(self, label, &block)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Case
        def _case_statement(expression, &block)
          stmt = RbVHDL::Ast.case_statement(self, expression, &block)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module ComponentInstantiation
        def _component_instantiation_statement(label, component_name, &block)
          stmt = RbVHDL::Ast.component_instantiation_statement(self, label, component_name, &block)
          @_statement_list.push(stmt)
          return stmt
        end
        def _entity_instantiation_statement(label, entity_name, architecture_name, &block)
          stmt = RbVHDL::Ast.entity_instantiation_statement(self, label, entity_name, architecture_name, &block)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Generate
        def _if_generate_statement(label, condition, &block)
          stmt = RbVHDL::Ast.if_generate_statement(self, label, condition, &block)
          @_statement_list.push(stmt)
          return stmt
        end
        def _for_generate_statement(label, index_identifier, index_range, &block)
          stmt = RbVHDL::Ast.for_generate_statement(self, label, index_identifier, index_range, &block)
          @_statement_list.push(stmt)
          return stmt
        end
      end
  
      module If
        def _if_statement(condition, &block)
          stmt = RbVHDL::Ast.if_statement(self, condition, &block)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module Loop
        def _loop_statement(&block)
          stmt = RbVHDL::Ast.loop_statement(self, &block)
          @_statement_list.push(stmt)
          return stmt
        end
        def _for_loop_statement(index_identifier, index_range, &block)
          stmt = RbVHDL::Ast.for_loop_statement(self, index_identifier, index_range, &block)
          @_statement_list.push(stmt)
          return stmt
        end
        def _while_loop_statement(condition, &block)
          stmt = RbVHDL::Ast.while_loop_statement(self, condition, &block)
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
        def _process_statement(&block)
          stmt = RbVHDL::Ast.process_statement(self, &block)
          @_statement_list.push(stmt)
          return stmt
        end
      end

      module ProcedureCall
        def _procedure_call(name, &block)
          stmt = RbVHDL::Ast.procedure_call(self, name, &block)
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
        include Comment
        include Block
        include Process
        include ProcedureCall
        include Assertion
        include SignalAssignment
        include ComponentInstantiation
        include Generate
      end

      module Sequential
        include Comment
        include Assertion
        include Report
        include SignalAssignment
        include VariableAssignment
        include ProcedureCall
        include If
        include Case
        include Loop
        include Null
        include Return
        include Wait
      end

    end
  end
end
