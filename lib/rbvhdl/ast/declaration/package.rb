require_relative '../association/methods'
require_relative '../declaration/methods'
require_relative '../interface/methods'

module RbVHDL::Ast

  module Declaration

    class Package
      attr_reader   :_owner
      attr_reader   :_identifier
      attr_reader   :_generic_interface_list
      attr_reader   :_generic_association_list
      attr_reader   :_declarative_item_list
      attr_reader   :_annotation
    
      def initialize(owner, identifier)
        @_owner                    = owner
        @_identifier               = identifier
        @_generic_interface_list   = []
        @_generic_association_list = []
        @_declarative_item_list    = []
        @_annotation               = Hash.new
      end

      include RbVHDL::Ast::Interface::Methods::Generic
      include RbVHDL::Ast::Association::Methods::Generic
      include RbVHDL::Ast::Declaration::Methods::PackageItem
    end

  end

  def self.package_declaration(owner, identifier)
    return RbVHDL::Ast::Declaration::Package.new(owner, RbVHDL::Ast.identifier(identifier))
  end
end
