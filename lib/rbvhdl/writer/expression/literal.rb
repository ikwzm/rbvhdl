module RbVHDL::Ast

  class Expression

    class DecimalLiteral
      RbVHDL::Writer._write_directive(self, {:format          => "%<integer>d%{fraction}%{exponent}",
                                             :fraction_format => ".%<fraction>d"                    ,
                                             :exponent_format => "%{keyword}%{sign}%<integer>d"
                                            }
                                     )
      def _write_string(directive={})
        if @_fraction.nil? then
          fraction = ""
        else
          fraction = directive.fetch(:fraction_format, self.class._write_directive[:fraction_format]) % {fraction: @_fraction}
        end
        if @_exponent.nil? then
          exponent = ""
        else
          exponent = @_exponent._write_string({:format => directive.fetch(:exponent_format, self.class._write_directive[:exponent_format])})
        end
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {integer: @_integer, fraction: fraction, exponent: exponent}
      end
    end

    class BasedLiteral
      RbVHDL::Writer._write_directive(self, {:format          => "%{base}#%{integer}%{fraction}#%{exponent}",
                                             :base_format     => "%<base>d"                                 ,
                                             :fraction_format => ".%{fraction}"                             ,
                                             :exponent_format => "%{keyword}%{sign}%<integer>d"
                                            }
                                     )
      def _write_string(directive={})
        if @_fraction.nil? then
          fraction = ""
        else
          fraction = directive.fetch(:fraction_format, self.class._write_directive[:fraction_format]) % {fraction: @_fraction}
        end
        if @_exponent.nil? then
          exponent = ""
        else
          exponent = @_exponent._write_string({:format => directive.fetch(:exponent_format, self.class._write_directive[:exponent_format])})
        end
        base   = directive.fetch(:base_format, self.class._write_directive[:base_format]) % {base: @_base}
        format = directive.fetch(:format     , self.class._write_directive[:format     ])
        return format % {base: base, integer: @_integer, fraction: fraction, exponent: exponent}
      end
    end

    class Exponent
      RbVHDL::Writer._write_directive(self, {:keyword => "E", :format => "%{keyword}%{sign}%<integer>d"})

      def _write_string(directive={})
        keyword = directive.fetch(:keyword, self.class._write_directive[:keyword])
        format  = directive.fetch(:format , self.class._write_directive[:format ])
        sign    = (@_sign == :"+")? "+" : ""
        return format % {keyword: keyword, sign: sign, integer: @_number}
      end
    end

    class PhysicalLiteral
      RbVHDL::Writer._write_directive(self, {:format => "%{decimal} %{unit}"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {decimal: @_decimal._write_string({}), unit: @_unit_name._write_string({})}
      end
    end
    
    class CharacterLiteral
      RbVHDL::Writer._write_directive(self, {:format => "'%{character}'"})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {character: @_value}
      end
    end
    
    class StringLiteral
      RbVHDL::Writer._write_directive(self, {:format => "\"%{string}\""})

      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        return format % {string: @_value}
      end
    end

    class BitStringLiteral
      RbVHDL::Writer._write_directive(self, {:format           => "%{width}%{base}\"%{string}\"",
                                             :width_format     => "%<width>d",
                                             :binary_base      => "B",
                                             :octal_base       => "O",
                                             :hexadecimal_base => "X",
                                             :decimal_base     => "D"
                                            }
                                     )
      def _write_string(directive={})
        format = directive.fetch(:format, self.class._write_directive[:format])
        if @_width.nil? then
          width = ""
        else
          width = directive.fetch(:width_format, self.class._write_directive[:width_format]) % {width: @_width}
        end
        if    @_base == :B then base_name = :binary_base
        elsif @_base == :O then base_name = :octal_base
        elsif @_base == :X then base_name = :hexadecimal_base
        elsif @_base == :D then base_name = :decimal_base
        end
        base = directive.fetch(base_name, self.class._write_directive[base_name])
        return format % {width: width, base: base, string: @_value}
      end
    end
    
    class NullLiteral
      RbVHDL::Writer._write_directive(self, {:keyword => "null", :format => "%{keyword}"})
      
      def _write_string(directive={})
        format  = directive.fetch(:format , self.class._write_directive[:format ])
        keyword = directive.fetch(:keyword, self.class._write_directive[:keyword])
        return format % {keyword: keyword}
      end
    end
  end
end
