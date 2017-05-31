module RbVHDL::Ast

  class Association

    class ActualPart
      attr_accessor :_owner
      def initialize(owner)
        @_owner = owner
      end
    end

    class ActualName < ActualPart
      attr_reader   :_name
      def initialize(name)
        super(nil)
        @_name = name
      end
    end

    class ActualFunction < ActualPart
      attr_reader   :_name
      attr_reader   :_designator
      def initialize(name, designator)
        super(nil)
        @_name       = name
        @_designator = designator
      end
    end

    class ActualTypeMark < ActualPart
      attr_reader   :_type_mark
      attr_reader   :_designator
      def initialize(type_mark, designator)
        super(nil)
        @_type_mark  = type_mark
        @_designator = designator
      end
    end

    class ActualExpression < ActualPart
      attr_reader   :_expression
      def initialize(expression)
        super(nil)
        @_expression = expression
      end
    end

    class ActualOpen < ActualPart
      def initialize
        super(nil)
      end
    end

  end

  def self.association_actual_name(name)
    return RbVHDL::Ast::Association::ActualName.new(RbVHDL::Ast.name(name))
  end
    
  def self.association_actual_function(name, designator)
    return RbVHDL::Ast::Association::ActualFunction.new(RbVHDL::Ast.name(name), RbVHDL::Ast.name(designator))
  end
    
  def self.association_actual_typemark(name, designator)
    return RbVHDL::Ast::Association::ActualFunction.new(RbVHDL::Ast.type.mark(name), RbVHDL::Ast.name(designator))
  end
    
  def self.association_actual_expression(expression)
    return RbVHDL::Ast::Association::ActualExpression.new(RbVHDL::Ast.expression(expression))
  end
    
  def self.association_actual_open
    return RbVHDL::Ast::Association::ActualOpen.new
  end
    
end

