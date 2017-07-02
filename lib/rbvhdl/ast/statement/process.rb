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
    
      def initialize(owner, &block)
        @_owner                 = owner
        @_label                 = nil
        @_postponed             = nil
        @_sensitivity_list      = []
        @_sensitivity_all       = false
        @_declarative_item_list = []
        @_statement_list        = []
        @_annotation            = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      def _label!(label, &block)
        @_label = RbVHDL::Ast.label_or_nil(label)
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      def _postponed!(&block)
        @_postponed = true
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      def _sensitivity_signal!(*names, &block)
        @_sensitivity_list.concat(names.map{ |name| RbVHDL::Ast.name(name) })
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      def _sensitivity_all!(&block)
        @_sensitivity_all = true
        if block_given? then
          self.instance_eval(&block)
        end
        return self
      end

      include RbVHDL::Ast::Declaration::Methods::ProcessItem
      include RbVHDL::Ast::Statement::Methods::Sequential
    end
  end

  def self.process_statement(owner, &block)
    return RbVHDL::Ast::Statement::Process.new(owner, &block)
  end
  
end
