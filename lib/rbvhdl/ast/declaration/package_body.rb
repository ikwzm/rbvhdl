require_relative '../declaration/methods'

module RbVHDL::Ast

  module Declaration

    class PackageBody
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_declarative_item_list
      attr_reader   :_annotation
    
      def initialize(owner, identifier)
        @_owner                   = owner
        @_identifier              = identifier
        @_declarative_item_list   = []
        @_annotation              = Hash.new
      end

      include RbVHDL::Ast::Declaration::Methods::PackageBodyItem
    end

  end

  def self.package_body(owner, identifier)
    return RbVHDL::Ast::Declaration::PackageBody.new(owner, RbVHDL::Ast.identifier(identifier))
  end
  
end
