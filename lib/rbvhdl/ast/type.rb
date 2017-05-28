module RbVHDL::Ast

  require_relative 'type/mark'
  require_relative 'type/definition'
  require_relative 'type/indication'
  require_relative 'type/range'

  def self.subtype_indication(type)
    if    type.class == RbVHDL::Ast::Type::Indication then
      return type
    else
      return RbVHDL::Ast::Type::Indication.new(RbVHDL::Ast.type_mark(type))
    end
  end
  
end
