module RbVHDL::Ast
  module Declaration

    class Type
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_type_definition
      attr_reader   :_annotation
    
      def initialize(owner, identifier, type_definition)
        @_owner           = owner
        @_identifier      = identifier
        @_type_definition = type_definition
        @_annotation      = Hash.new
      end
    end

    class IntegerType  < Type
    end

    class FloatingType < Type
    end

    class PhysicalType < Type
    end

    class ArrayType    < Type
    end

    class EnumerationType < Type
      def _enum!(identifier)
        @_type_definition._enum!(identifier)
        return self
      end
    end

    class RecordType < Type
      def _field!(identifier, type)
        @_type_definition._field!(identifier, type)
        return self
      end
    end
      
    class FileType   < Type
    end
      
    class AccessType < Type
    end

  end

  def self.enumeration_type_declaration(owner, ident, enum_list=nil)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.enumeration_type_definition(enum_list)
    return RbVHDL::Ast::Declaration::EnumerationType.new(owner, identifier, type_def)
  end

  def self.integer_type_declaration(owner, ident, range)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.integer_type_definition(range)
    return RbVHDL::Ast::Declaration::IntegerType.new(owner, identifier, type_def)
  end
    
  def self.floating_type_declaration(owner, ident, range)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.floating_type_definition(range)
    return RbVHDL::Ast::Declaration::FloatingType.new(owner, identifier, type_def)
  end
    
  def self.physical_type_declaration(owner, ident, range, physical_ident, unit_list=nil)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.physical_type_definition(range, physical_ident, unit_list)
    return RbVHDL::Ast::Declaration::PhysicalType.new(owner, identifier, type_def)
  end
    
  def self.array_type_declaration(owner, ident, range, type)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.array_type_definition(range, type)
    return RbVHDL::Ast::Declaration::ArrayType.new(owner, identifier, type_def)
  end
    
  def self.record_type_declaration(owner, ident, record=nil)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.record_type_definition(record)
    return RbVHDL::Ast::Declaration::RecordType.new(owner, identifier, type_def)
  end

  def self.file_type_declaration(owner, ident, type)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.file_type_definition(type)
    return RbVHDL::Ast::Declaration::FileType.new(owner, identifier, type_def)
  end
    
  def self.access_type_declaration(owner, ident, type)
    identifier = RbVHDL::Ast.identifier(ident)
    type_def   = RbVHDL::Ast.access_type_definition(type)
    return RbVHDL::Ast::Declaration::AccessType.new(owner, identifier, type_def)
  end
    
end
