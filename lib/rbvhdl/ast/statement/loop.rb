require_relative '../statement/methods'

module RbVHDL::Ast

  module Statement

    class Loop
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_statement_list
      attr_reader   :_annotation

      def initialize(owner)
        @_owner          = owner
        @_label          = nil
        @_statement_list = []
        @_annotation     = Hash.new
      end

      def _label!(label)
        @_label          = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      include RbVHDL::Ast::Statement::Methods::Sequential
    end

    class WhileLoop < Loop
      attr_reader   :_condition
      def initialize(owner, condition)
        super(owner)
        @_condition = condition
      end
    end

    class ForLoop < Loop
      attr_reader   :_index_identifier
      attr_reader   :_index_range
      def initialize(owner, index_identifier, index_range)
        super(owner)
        @_index_identifier = index_identifier
        @_index_range      = index_range
      end
    end

    class Next
      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_next_label
      attr_accessor :_condition
      attr_reader   :_annotation

      def initialize(owner)
        @_owner      = owner
        @_label      = nil
        @_loop_label = nil
        @_condition  = nil
        @_annotation = Hash.new
      end

      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _next_label!(label)
        @_next_label = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _when!(condition)
        @_condition  = RbVHDL::Ast.expression(condition)
        return self
      end
    end
  
    class Exit
      attr_reader   :_owner
      attr_reader   :_label
      attr_accessor :_exit_label
      attr_accessor :_condition
      attr_reader   :_annotation

      def initialize(owner)
        @_owner      = owner
        @_label      = nil
        @_exit_label = nil
        @_condition  = nil
        @_annotation = Hash.new
      end

      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _exit_label!(label)
        @_exit_label = RbVHDL::Ast.label_or_nil(label)
        return self
      end

      def _when!(condition)
        @_condition  = RbVHDL::Ast.expression(condition)
        return self
      end
    end

  end

  def self.loop_statement(owner)
    return RbVHDL::Ast::Statement::Loop.new(owner)
  end

  def self.while_loop_statement(owner, condition)
    return RbVHDL::Ast::Statement::WhileLoop.new(owner, RbVHDL::Ast.expression(condition))
  end

  def self.for_loop_statement(owner, index_identifier, index_range)
    _index_identifier = RbVHDL::Ast.identifier(index_identifier)
    if index_range.class < RbVHDL::Ast::Type::Range then
      return RbVHDL::Ast::Statement::ForLoop.new(owner, _index_identifier, index_range)
    else
      raise "abort #{self.class}.#{__method__}(#{index_range}:#{index_range.class}): Illegal class"
    end
  end

  def self.next_statement(owner)
    return RbVHDL::Ast::Statement::Next.new(owner)
  end
    
  def self.exit_statement(owner)
    return RbVHDL::Ast::Statement::Exit.new(owner)
  end
    
end
