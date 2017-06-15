module RbVHDL::Ast

  class Interface

    class Mode
    end

    class Mode

      class In    < Mode
      end

      class Out   < Mode
      end

      class Inout < Mode
      end
    end
  end

  def self.interface_mode(mode)
    if    mode.class < RbVHDL::Ast::Interface::Mode then
      return mode
    elsif mode.class == Symbol then
      case mode.downcase
      when :in     then return RbVHDL::Ast::Interface::Mode::In.new
      when :out    then return RbVHDL::Ast::Interface::Mode::Out.new
      when :inout  then return RbVHDL::Ast::Interface::Mode::Inout.new
      end
    elsif mode.class == String then
      case mode.downcase
      when "in"    then return RbVHDL::Ast::Interface::Mode::In.new
      when "out"   then return RbVHDL::Ast::Interface::Mode::Out.new
      when "inout" then return RbVHDL::Ast::Interface::Mode::Inout.new
      end
    end
    raise ArgumentError, "#{self.inspect}.#{__method__}(#{mode.inspect}:#{mode.class})"
  end

  def self.interface_mode_or_nil(mode)
    if mode.nil? then
      return nil
    else
      return self.interface_mode(mode)
    end
  end
end
