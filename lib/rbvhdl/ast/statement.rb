module RbVHDL::Ast
  require_relative 'statement/methods'
  require_relative 'statement/assertion'
  require_relative 'statement/block'
  require_relative 'statement/procedure_call'
  require_relative 'statement/process'
  require_relative 'statement/signal_assignment'
  require_relative 'statement/component_instantiation'
  require_relative 'statement/generate'
  require_relative 'statement/wait'
  require_relative 'statement/report'
  require_relative 'statement/variable_assignment'
  require_relative 'statement/if'
  require_relative 'statement/case'
  require_relative 'statement/loop'
  require_relative 'statement/return'
  require_relative 'statement/null'
end