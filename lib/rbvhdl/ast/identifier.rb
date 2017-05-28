require 'delegate'

module RbVHDL::Ast

  class Identifier < DelegateClass(Symbol)
  end

  def self.identifier(name)
    if    name.class == Identifier then return name
    elsif name.class == Symbol     then return Identifier.new(name)
    elsif name.class == String     then return Identifier.new(name.to_sym)
    else  raise "abort #{self.class}.#{__method__}(#{name}:#{name.class}): Illegal class"
    end
  end

  def self.identifier_list(list)
    if list.class == Array then
      return list.map{|name| self.identifier(name)}
    else
      return [self.identifier(list)]
    end
  end

end
