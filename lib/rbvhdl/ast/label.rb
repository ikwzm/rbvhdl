require_relative 'identifier'

module RbVHDL::Ast

  class Label < Identifier
  end

  def self.label(name)
    if    name.class == Label      then return name
    elsif name.class == Identifier then return Label.new(name.to_sym)
    elsif name.class == Symbol     then return Label.new(name)
    elsif name.class == String     then return Label.new(name.to_sym)
    else  raise ArgumentError, "#{self.inspect}.#{__method__}(#{name.inspect}:#{name.class})"
    end
  end

  def self.label_or_nil(name)
    return (name.nil?) ? nil : self.label(name)
  end

end
