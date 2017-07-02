module RbVHDL::Ast

  module Statement

    class SignalAssignment
      attr_reader   :_owner
      attr_reader   :_label
      attr_reader   :_target
      attr_accessor :_postponed
      attr_accessor :_guarded
      attr_accessor :_delay
      attr_reader   :_annotation

      def initialize(owner, target)
        @_owner      = owner
        @_label      = nil
        @_target     = target
        @_postponed  = nil
        @_guarded    = nil
        @_delay      = nil
        @_annotation = Hash.new
      end

      def _label!(label)
        @_label      = RbVHDL::Ast.label_or_nil(label)
        return self
      end
      
      def _postponed!
        @_postponed  = true
        return self
      end

      def _guarded!
        @_guarded    = true
        return self
      end

      def _delay!(delay)
        @_delay      = RbVHDL::Ast.delay_mechanism(delay)
        return self
      end

      def _transport!
        @_delay      = RbVHDL::Ast.transport
        return self
      end

      def _inertial!(expression=nil)
        @_delay      = RbVHDL::Ast.inertial(expression)
      end
    end

    class SimpleSignalAssignment      < SignalAssignment
      attr_reader   :_waveform

      def initialize(owner, target, waveform=nil)
        super(owner, target)
        @_waveform = waveform
      end

      def _value!(value)
        if @_waveform.nil? then
          @_waveform = RbVHDL::Ast.waveform_or_nil(value)
        else
          @_waveform._value!(value)
        end
        return self
      end
      
      def _after!(time)
        @_waveform._after!(time)
        return self
      end

      def _when!(condition)
        conditional_assignment = RbVHDL::Ast.conditional_signal_assignment_statement(@_owner, @_target, @_waveform)
        conditional_assignment._when!(condition)
        return conditional_assignment
      end
      
    end

    class ConditionalSignalAssignment < SignalAssignment
      attr_reader   :_waveform_list

      def initialize(owner, target, waveform=nil)
        super(owner, target)
        if waveform.nil? then
          @_waveform_list = []
        else
          @_waveform_list = [[waveform, nil]]
        end
      end

      def _value!(value)
        if @_waveform_list.size > 0 then
          @_waveform_list.last[0]._value!(value)
        else
          @_waveform_list.push([RbVHDL::Ast.waveform(value), nil])
        end
        return self
      end
      
      def _after!(time)
        @_waveform_list.last[0]._after!(time)
        return self
      end
      
      def _when!(condition)
        @_waveform_list.last[1] = RbVHDL::Ast.expression(condition)
        return self
      end

      def _else!(value=nil)
        @_waveform_list.push([RbVHDL::Ast.waveform(value), nil])
        return self
      end
    end

    class SelectedSignalAssignment    < SignalAssignment
      attr_reader   :_waveform_list
      attr_accessor :_expression

      def initialize(owner, expression, target, waveform=nil, choices=nil)
        super(owner, target)
        @_expression    = expression
        if waveform.nil? then
          @_waveform_list = []
        else
          @_waveform_list = [[waveform, choices]]
        end
      end

      def _value!(value)
        if @_waveform_list.size > 0 and @_waveform_list.last[1].nil? then
          @_waveform_list.last[0]._value!(value)
        else
          @_waveform_list.push([RbVHDL::Ast.waveform(value), nil])
        end
        return self
      end
      
      def _after!(time)
        @_waveform_list.last[0]._after!(time)
        return self
      end
      
      def _when!(choices)
        @_waveform_list.last[1] = RbVHDL::Ast.choices(choices)
        return self
      end

    end

    class Waveform
      attr_reader   :_list
      
      def initialize(value, time=nil)
        if value.nil? then
          @_list = []
        else
          @_list  = [[value, time]]
        end
      end

      def _after!(time)
        @_list.last[1] = RbVHDL::Ast.expression_or_nil(time)
        return self
      end

      def _value!(value)
        @_list.push([RbVHDL::Ast.expression(value), nil])
        return self
      end
    end

    class DelayMechanism
    end

    class Transport < DelayMechanism
    end

    class Inertial  < DelayMechanism
      attr_reader :_reject
      def initialize
        super
        @_reject = nil
      end
      def _reject!(expression)
        @_reject = RbVHDL::Ast.expression(expression)
        return self
      end
    end

  end

  def self.waveform(value, time=nil)
    if value.class == RbVHDL::Ast::Statement::Waveform then
      return value
    else
      _value = RbVHDL::Ast.expression_or_nil(value)
      _time  = RbVHDL::Ast.expression_or_nil(time )
      return RbVHDL::Ast::Statement::Waveform.new(_value, _time)
    end
  end

  def self.waveform_or_nil(value, time=nil)
    if value.nil? then
      return nil
    else
      return self.waveform(value, time)
    end
  end

  def self.delay_mechanism(delay)
    if delay.nil? or
       delay.class < RbVHDL::Ast::Statement::DelayMechanism then
      return delay
    else
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{delay.inspect}:#{delay.class})"
    end
  end

  def self.transport
    return RbVHDL::Ast::Statement::Transport.new
  end

  def self.inertial(expression=nil)
    return RbVHDL::Ast::Statement::Inertial.new.reject!(RbVHDL::Ast.expression_or_nil(expression))
  end

  def self.signal_assignment_target(target)
    if target.class < RbVHDL::Ast::Expression::Name or
       target.class < RbVHDL::Ast::Expression::Aggregate then
      return target
    else
      return RbVHDL::Ast.name(target)
    end
  end

  def self.signal_assignment_statement(owner, target, waveform=nil)
    return self.simple_signal_assignment_statement(owner, target, waveform)
  end

  def self.simple_signal_assignment_statement(owner, target, waveform=nil)
    _target   = RbVHDL::Ast.signal_assignment_target(target)
    _waveform = RbVHDL::Ast.waveform_or_nil(waveform)
    return RbVHDL::Ast::Statement::SimpleSignalAssignment.new(owner, _target, _waveform)
  end

  def self.conditional_signal_assignment_statement(owner, target, waveform=nil)
    _target   = RbVHDL::Ast.signal_assignment_target(target)
    _waveform = RbVHDL::Ast.waveform_or_nil(waveform)
    return RbVHDL::Ast::Statement::ConditionalSignalAssignment.new(owner, _target, _waveform)
  end

  def self.selected_signal_assignment_statement(owner, expression, target, waveform=nil, choices=nil)
    _target     = RbVHDL::Ast.signal_assignment_target(target)
    _expression = RbVHDL::Ast.expression(expression)
    _waveform   = RbVHDL::Ast.waveform_or_nil(waveform)
    _choices    = RbVHDL::Ast.choices_or_nil(choices)
    return RbVHDL::Ast::Statement::SelectedSignalAssignment.new(owner, _expression, _target, _waveform, _choices)
  end
    
end
