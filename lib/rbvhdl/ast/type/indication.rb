require_relative 'range'

module RbVHDL::Ast::Type

  class Indication

    class Constraint
    end

    class ArrayConstraint  < Constraint
      attr_accessor :_range_list
      attr_accessor :_constraint
      def initialize(range, constraint)
        if range.class == Array then
          @_range_list = range
        else
          @_range_list = [range]
        end
        @_constraint = constraint
      end
    end
    
    class RecordConstraint < Constraint
    end

    class RangeConstraint  < Constraint
      attr_reader :_range
      def initialize(_range)
        @_range = _range
      end
    end

    attr_reader   :_type_mark   # RbVHDL::Ast::Expression::Name
    attr_accessor :_constraint  # RbVHDL::Ast::Type::Indication::Constraint or nil
    attr_accessor :_resolution  # T.B.D

    def initialize(type_mark)
      @_type_mark  = type_mark
      @_resolution = nil
      @_constraint = nil
    end

    def _downto(l,r)
      range = RbVHDL::Ast.range_downto(l,r)
      if    @_constraint.nil? then
        @_constraint = ArrayConstraint.new(range, nil)
      elsif @_constraint.class == ArrayConstraint then
        @_constraint._range_list.push(range)
      else
        raise TypeError, "#{self.class}.#{__method__}): @_constraint.class is #{@_constraint.class}"
      end
      return self
    end

    def _to(l,r)
      range = RbVHDL::Ast.range_to(l,r)
      if    @_constraint.nil? then
        @_constraint = ArrayConstraint.new(range, nil)
      elsif @_constraint.class == ArrayConstraint then
        @_constraint._range_list.push(range)
      else
        raise TypeError, "#{self.class}.#{__method__}): @_constraint.class is #{@_constraint.class}"
      end
      return self
    end

    def _range_attr(name)
      @_constraint = RangeConstraint.new(RbVHDL::Ast.range_attr(name))
      return self
    end

    def _range_to(l,r)
      @_constraint = RangeConstraint.new(RbVHDL::Ast.range_to(l,r))
      return self
    end

    def _range_downto(l,r)
      @_constraint = RangeConstraint.new(RbVHDL::Ast.range_downto(l,r))
      return self
    end

  end
end
