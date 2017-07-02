require_relative '../association/generic'
require_relative '../association/port'

module RbVHDL::Writer

  module Statement

    module ComponentInstantiation

      def _write_line(directive={})
        write_line = []
        indent     = directive.fetch(:indent, "")
        label      = @_label._write_string
        name       = @_name._write_string

        keyword_format  = directive.fetch(:keyword_format , self.class::WRITE_DIRECTIVE[:keyword_format])
        format          = directive.fetch(:format         , self.class::WRITE_DIRECTIVE[:format        ])
        reserved_words  = directive.fetch(:reserved_words , self.class::WRITE_DIRECTIVE[:reserved_words])

        generic_assocation_directive = directive.dup
        port_assocation_directive    = directive.dup

        if    @_port_association_list.size    > 0 then
          begin_separator                          = ""
          generic_assocation_directive[:separator] = ""
          port_assocation_directive[:separator]    = ";"
        elsif @_generic_association_list.size > 0 then
          begin_separator                          = ""
          generic_assocation_directive[:separator] = ";"
          port_assocation_directive[:separator]    = ""
        else
          begin_separator                          = ";"
          generic_assocation_directive[:separator] = ""
          port_assocation_directive[:separator]    = ""
        end

        write_line.push format % {
          :indent    => indent,
          :keyword   => keyword_format % {keyword: reserved_words[self.class::WRITE_DIRECTIVE[:class]]},
          :label     => label,
          :name      => name,
          :separator => begin_separator,
        }

        write_line.concat _write_generic_association(generic_assocation_directive)
        write_line.concat _write_port_association(port_assocation_directive)

        return write_line
      end
    end

  end
end

module RbVHDL::Ast

  module Statement

    class ComponentInstantiation
      WRITE_DIRECTIVE = {
        :class             => :component,
        :reserved_words    => RbVHDL::Writer::RESERVED_WORDS,
        :keyword_format    => "",
        :format            => "%{indent}%{label}: %{keyword}%{name}%{separator}",
      }.merge( RbVHDL::Writer::Association::Generic::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge( RbVHDL::Writer::Association::Port::WRITE_DIRECTIVE    ){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Statement::ComponentInstantiation
      include RbVHDL::Writer::Association::Generic::WriteAssociation
      include RbVHDL::Writer::Association::Port::WriteAssociation
    end

    class EntityInstantiation
      WRITE_DIRECTIVE = {
        :class             => :entity,
        :reserved_words    => RbVHDL::Writer::RESERVED_WORDS,
        :keyword_format    => "%{keyword} ",
        :format            => "%{indent}%{label}: %{keyword}%{name}%{separator}",
      }.merge( RbVHDL::Writer::Association::Generic::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
       .merge( RbVHDL::Writer::Association::Port::WRITE_DIRECTIVE    ){|key, base_val, default_val| base_val}
      include RbVHDL::Writer::Statement::ComponentInstantiation
      include RbVHDL::Writer::Association::Generic::WriteAssociation
      include RbVHDL::Writer::Association::Port::WriteAssociation
    end
    
  end
end
