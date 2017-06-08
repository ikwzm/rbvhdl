require_relative '../interface/methods'

module RbVHDL::Ast
  module Interface

    class Variable
      RbVHDL::Writer._write_directive(self, {:keyword              => "variable",
                                             :format               => "%{indent}%{keyword}%{identifier}%{mode}%{type}%{value}%{separator}",
                                             :keyword_format       => "%<keyword>-8s",
                                             :identifier_format    => "%{identifier}",
                                             :identifier_separator => ",",
                                             :mode_format          => " : %{mode} ", 
                                             :type_format          => "%{type}",
                                             :value_format         => " := %{expression}",
                                            }
                                     )
      include RbVHDL::Writer::Interface::Methods::WriteLine
    end
  end
end

