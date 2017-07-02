require_relative '../association/methods'
require_relative '../declaration/methods'
require_relative '../interface/methods'

module RbVHDL::Ast

  module Declaration
    #
    # package_declaration : "package" identifier "is"
    #                         { package_declarative_item }
    #                       "end" [ "package" ] [ identifier ] ";"
    #
    class Package
      attr_reader   :_owner
      attr_reader   :_identifier                # RbVHDL::Ast::Identifer
      attr_reader   :_generic_interface_list    # Array of RbVHDL::Ast::Interface::Constant
      attr_reader   :_generic_association_list  # Array of RbVHDL::Ast::Association
      attr_reader   :_declarative_item_list     # Array of RbVHDL::Ast::Declaration::*
      attr_reader   :_annotation
    
      def initialize(owner, identifier, &block)
        @_owner                    = owner
        @_identifier               = identifier
        @_generic_interface_list   = []
        @_generic_association_list = []
        @_declarative_item_list    = []
        @_annotation               = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      include RbVHDL::Ast::Interface::Methods::Generic
      include RbVHDL::Ast::Association::Methods::Generic
      include RbVHDL::Ast::Declaration::Methods::PackageItem
    end
  end

  def self.package_declaration(owner, identifier, &block)
    return RbVHDL::Ast::Declaration::Package.new(owner, RbVHDL::Ast.identifier(identifier), &block)
  end
end
