require_relative 'primary'
require_relative '../association/methods'

module RbVHDL::Ast

  class Expression

    class Name < Primary
    end

    class SimpleName   < Name
      attr_reader   :_name
      def initialize(name)
        super()
        @_name = name
      end
    end

    class FunctionCall < Name
      attr_reader   :_name
      attr_reader   :_parameter_association_list
      def initialize(name)
        super()
        @_name = name
        @_parameter_association_list = []
      end
      include RbVHDL::Ast::Association::Methods::Parameter
    end

    class IndexedName  < Name
      attr_reader   :_prefix
      attr_reader   :_index_list
      def initialize(prefix, expression)
        super()
        @_prefix     = prefix
        @_index_list = []
        @_index_list.push(expression) unless expression.nil?
      end
    end

    class SliceName    < Name
      attr_reader   :_prefix
      attr_reader   :_range
      def initialize(prefix, range)
        super()
        @_prefix = prefix
        @_range  = range
      end
    end

    class SelectedName < Name
      attr_reader   :_prefix
      attr_reader   :_suffix
      def initialize(prefix, suffix)
        super()
        @_prefix = prefix
        @_suffix = suffix
      end
    end

    class All < Name
      def initialize
        super()
      end
    end

    class AttributeName < Name
      attr_reader   :_name
      attr_reader   :_attribute
      attr_reader   :_signature
      attr_reader   :_expression
      def initialize(name, attribute, signature=nil, expression=nil)
        super()
        @_name       = name
        @_attribute  = attribute
        @_signature  = signature
        @_expression = expression
      end
    end

    class Name

      def _index(expression)
        if expression.class == Array then
          expression_list = expression.map{|expr| RbVHDL::Ast.expression(expr)}
        else
          expression_list = [RbVHDL::Ast.expression(expression)]
        end
        name = IndexedName.new(self, nil)
        name._index_list.concat(expression_list)
        name._annotation.merge(self._annotation)
        return name
      end

      def _slice(range)
        if range.class < RbVHDL::Ast::Type::Range then
          name = SliceName.new(self, range)
          name._annotation.merge(self._annotation)
          return name
        else
          raise ArgumentError, "#{self.inspect}.#{__method__}(#{range.inspect}:#{range.class})"
        end
      end

      def _to(l, r)
        name = SliceName.new(self, RbVHDL::Ast.range_to(l,r))
        name._annotation.merge(self._annotation)
        return name
      end

      def _downto(l, r)
        name = SliceName.new(self, RbVHDL::Ast.range_downto(l,r))
        name._annotation.merge(self._annotation)
        return name
      end

      def _select(suffix)
        name = SelectedName.new(self, RbVHDL::Ast.name(suffix))
        name._annotation.merge(self._annotation)
        return name
      end

      def _select_all
        name = SelectedName.new(self, RbVHDL::Ast.all)
        name._annotation.merge(self._annotation)
        return name
      end

      def _call(associations)
        function_call = FunctionCall.new(self)
        function_call._add_parameter_associations(associations)
        function_call._annotation.merge(self._annotation)
        return function_call
      end

      def _attribute(attribute, signature=nil, expression=nil)
        name = AttributeName.new(self, RbVHDL::Ast.identifier(attribute), signature, RbVHDL::Ast.expression_or_nil(expression))
        name._annotation.merge(self._annotation)
        return name
      end
    end

  end

  def self.name(name)
    if name.class < RbVHDL::Ast::Expression::Name then
      return name
    else
      return RbVHDL::Ast::Expression::SimpleName.new(RbVHDL::Ast.identifier(name))
    end
  end

  def self.all
    return RbVHDL::Ast::Expression::All.new
  end
  
end
