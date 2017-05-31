module RbVHDL::Ast

  module Declaration
    #
    # group_declaration : "group" identifier : group_template_name "(" ( name | character_literal) ["," ...] ")" ";"
    #
    class Group
      attr_reader   :_owner
      attr_reader   :_identifier          # RbVHDL::Ast::Identifer
      attr_reader   :_template_name       # RbVHDL::Ast::Expression::Name
      attr_reader   :_name_list           # Array of RbVHDL::Ast::Expression::Name | RbVHDL::Ast::Expression::CharacterLiteral
      
      def initialize(owner, identifier, template_name, name_list=[])
        @_owner         = owner
        @_identifier    = identifier
        @_template_name = template_name
        @_name_list     = name_list
      end
    end
  end

  def self.group_declaration(owner, identifier, template_name, name_list=[])
    _identifier    = RbVHDL::Ast.identifier(identifier)
    _template_name = RbVHDL::Ast.name(template_name)
    if    name_list.nil? then
      _name_list = []
    elsif name_list.class <  RbVHDL::Ast::Expression::Name or
          name_list.class == RbVHDL::Ast::Expression::CharacterLiteral then
      _name_list = [name_list]
    elsif name_list.class == Array then
      if name_list.reject{ |name| name.class < RbVHDL::Ast::Expression::Name or name.class == RbVHDL::Ast::Expression::CharacterLiteral}.count == 0 then
        _name_list = name_list
      else
        _name_list = nil
      end
    else
        _name_list = nil
    end
    if _name_list.nil? then
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{owner.inspect}, #{identifier.inspect}, #{template_name.inspect}, #{name_list.inspect}:#{name_list.class})"
    end
    return RbVHDL::Ast::Declaration::Group.new(owner, _identifier, _template_name, _name_list)
  end
  
end
