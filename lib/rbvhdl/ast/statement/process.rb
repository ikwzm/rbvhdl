require_relative '../declaration/methods'
require_relative '../statement/methods'

module RbVHDL::Ast

  module Statement

    class Process
      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_postponed
      attr_reader   :_sensitivity_all
      attr_reader   :_sensitivity_list
      attr_reader   :_declarative_item_list
      attr_reader   :_statement_list
      attr_reader   :_annotation
    
      def initialize(owner)
        @_owner                 = owner
        @_label                 = nil
        @_postponed             = nil
        @_sensitivity_list      = []
        @_sensitivity_all       = false
        @_declarative_item_list = []
        @_statement_list        = []
        @_annotation            = Hash.new
      end

      def _label!(label)
        @_label = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _postponed!
        @_postponed = true
        return self
      end

      def _sensitivity_signal!(*names)
        @_sensitivity_list.concat(names.map{ |name| RbVHDL::Ast.name(name) })
        return self
      end

      def _sensitivity_all!
        @_sensitivity_all = true
        return self
      end

      include RbVHDL::Ast::Declaration::Methods::ProcessItem
      include RbVHDL::Ast::Statement::Methods::Sequential
    end
  end

  def self.process_statement(owner)
    return RbVHDL::Ast::Statement::Process.new(owner)
  end
  
end
