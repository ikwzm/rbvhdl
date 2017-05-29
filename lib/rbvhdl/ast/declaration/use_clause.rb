module RbVHDL::Ast

  module Declaration

    class UseClause
      attr_reader   :_owner
      attr_reader   :_name_list
      attr_reader   :_annotation

      def initialize(owner)
        @_owner      = owner
        @_name_list  = []
        @_annotation = Hash.new
      end

      def _use!(selected_name)
        @_name_list.push(selected_name)
        return self
      end

    end
  end

  def self.use_clause(owner, arg=nil)
    decl = RbVHDL::Ast::Declaration::UseClause.new(owner)
    if    arg.nil?                                           then name_list = []
    elsif arg.class == RbVHDL::Ast::Expression::SelectedName then name_list = [arg]
    elsif arg.class == Array                                 then
      if arg.reject{ |name| name.class == RbVHDL::Ast::Expression::SelectedName }.count == 0 then
        name_list = arg
      else
        name_list = nil
      end
    else
        name_list = nil
    end
    if name_list.nil? then
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{owner.inspect}, #{arg.inspect}:#{arg.class})"
    end
    name_list.each do |selected_name|
      decl._use!(selected_name)
    end
    return decl
  end

end
