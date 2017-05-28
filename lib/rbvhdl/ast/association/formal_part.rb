module RbVHDL::Ast

  class Association

    class FormalPart
      attr_accessor :_owner
      def initialize(owner)
        @_owner = owner
      end
    end

    class FormalIndex < FormalPart
      attr_reader   :_index
      def initialize(index)
        super(nil)
        @_index = index
      end
    end

    class FormalName < FormalPart
      attr_reader   :_name
      def initialize(name)
        super(nil)
        @_name = name
      end
    end

    class FormalFunction < FormalPart
      attr_reader   :_name
      attr_reader   :_designator
      def initialize(name, designator)
        super(nil)
        @_name       = name
        @_designator = designator
      end
    end

    class FormalTypeMark < FormalPart
      attr_reader   :_type_mark
      attr_reader   :_designator
      def initialize(type_mark, designator)
        super(nil)
        @_type_mark  = type_mark
        @_designator = designator
      end
    end

  end
  def self.association_formal_index(index)
    return RbVHDL::Ast::Association::FormalIndex.new(index)
  end
    
  def self.association_formal_name(name)
    return RbVHDL::Ast::Association::FormalName.new(RbVHDL::Ast.name(name))
  end
    
  def self.association_formal_function(name, designator)
    return RbVHDL::Ast::Association::FormalFunction.new(RbVHDL::Ast.name(name), RbVHDL::Ast.name(designator))
  end
    
  def self.association_formal_typemark(name, designator)
    return RbVHDL::Ast::Association::FormalFunction.new(RbVHDL::Ast.type.mark(name), RbVHDL::Ast.name(designator))
  end
    
end
