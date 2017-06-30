require_relative 'ast'
module RbVHDL

  module Writer
  end

  require_relative 'writer/reserved_words'
  require_relative 'writer/comment'
  require_relative 'writer/identifier'
  require_relative 'writer/label'
  require_relative 'writer/expression'
  require_relative 'writer/type'
  require_relative 'writer/statement'
  require_relative 'writer/declaration'
  require_relative 'writer/interface'
  require_relative 'writer/association'
  require_relative 'writer/library_clause'
  require_relative 'writer/design_unit'
end
