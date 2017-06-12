require_relative '../interface/methods'

module RbVHDL::Ast::Interface

  class Signal
    WRITE_DIRECTIVE = {
      :keyword              => "signal",
      :format               => "%{indent}%{keyword}%{identifier} %{mode}%{type}%{value}%{separator}",
      :keyword_format       => "%<keyword>-10s",
      :identifier_format    => "%{identifier}",
      :identifier_separator => ",",
      :mode_format          => " : %{mode} ", 
      :type_format          => "%{type}",
      :value_format         => " := %{expression}",
    }
    include RbVHDL::Writer::Interface::Methods::WriteLine
  end
end

