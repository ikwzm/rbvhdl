module RbVHDL::Ast

  module Type
    class Mark < RbVHDL::Ast::Identifier
    end
  end

  def self.type_mark(name)
    if    name.class == RbVHDL::Ast::Type::Mark then return name
    elsif name.class == RbVHDL::Ast::Identifier then return RbVHDL::Ast::Type::Mark.new(name)
    elsif name.class == Symbol                  then return RbVHDL::Ast::Type::Mark.new(name)
    elsif name.class == String                  then return RbVHDL::Ast::Type::Mark.new(name.to_sym)
    else raise ArgumentError, "#{self.inspect}.#{__method__}(name:#{name.class})"
    end
  end

end

