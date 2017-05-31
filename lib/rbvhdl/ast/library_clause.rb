module RbVHDL::Ast

  class LibraryClause
    attr_reader   :_owner
    attr_reader   :_identifier_list
    attr_reader   :_annotation

    def initialize(owner, identifier_list)
      @_owner           = owner
      @_identifier_list = identifier_list
      @_annotation      = Hash.new
    end

  end

  def self.library_clause(owner, identifier_list)
    return RbVHDL::Ast::LibraryClause.new(owner, RbVHDL::Ast.identifier_list(identifier_list))
  end

end
