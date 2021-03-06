require_relative '../declaration/methods'

module RbVHDL::Ast

  module Declaration
    #
    # package_body        : "package" "body" identifier "is"
    #                         { package_body_declarative_item }
    #                       "end" [ "package" "body" ] [ identifier ] ";"
    #
    class PackageBody
      attr_reader   :_owner
      attr_reader   :_identifier                # RbVHDL::Ast::Identifer
      attr_reader   :_declarative_item_list     # Array of RbVHDL::Ast::Declaration::*
      attr_reader   :_annotation
    
      def initialize(owner, identifier, &block)
        @_owner                   = owner
        @_identifier              = identifier
        @_declarative_item_list   = []
        @_annotation              = Hash.new
        if block_given? then
          self.instance_eval(&block)
        end
      end

      include RbVHDL::Ast::Declaration::Methods::PackageBodyItem
    end
  end

  def self.package_body(owner, identifier, &block)
    return RbVHDL::Ast::Declaration::PackageBody.new(owner, RbVHDL::Ast.identifier(identifier), &block)
  end
  
end
