module RbVHDL::Ast

  class Association
    attr_reader   :_owner
    attr_reader   :_formal_part
    attr_reader   :_actual_part
    def initialize(owner, formal_part, actual_part)
      @_owner       = owner
      @_formal_part = formal_part
      @_actual_part = actual_part
      @_formal_part._owner = self
      @_actual_part._owner = self
    end
  end

  require_relative 'association/formal_part'
  require_relative 'association/actual_part'

  def self.association(owner, formal, actual)
    if    formal.class <  RbVHDL::Ast::Association::FormalPart then
      formal_part = formal
    elsif formal.class <  Integer or   # for Ruby 2.3.7 or earlier
          formal.class == Integer then # for Ruby 2.4.0 or later 
      formal_part = self.association_formal_index(formal)
    else
      formal_part = self.association_formal_name(formal)
    end
    if    actual.class <  RbVHDL::Ast::Association::ActualPart then
      actual_part = actual
    elsif actual.class <  RbVHDL::Ast::Expression::Name  then
      actual_part = self.association_actual_name(actual)
    elsif actual.class <  RbVHDL::Ast::Expression        or
          actual.class <  Integer or   # for Ruby 2.3.7 or earlier
          actual.class == Integer or   # for Ruby 2.4.0 or later 
          actual.class == Float   then
      actual_part = self.association_actual_expression(actual)
    else
      actual_part = self.association_actual_name(actual)
    end
    return RbVHDL::Ast::Association.new(owner, formal_part, actual_part)
  end

end
