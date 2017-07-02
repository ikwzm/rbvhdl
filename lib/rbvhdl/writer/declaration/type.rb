module RbVHDL::Writer

  module Declaration

    module Type

      WRITE_DIRECTIVE = {
        :reserved_words         => RbVHDL::Writer::RESERVED_WORDS,
        :format                 => "%{indent}%{keyword} %{identifier}%{type_definition};",
        :keyword_format         => "%<keyword>-9s",
        :type_definition_format => " %{_is_} %{type_definition}",
        :identifier_format      => "%{identifier}",
        :identifier_align       => true,
      }

      module WriteLine

        def _write_line(directive={})
          indent            = directive.fetch(:indent   , "" )
          format            = directive.fetch(:format            , self.class::WRITE_DIRECTIVE[:format              ])
          reserved_words    = directive.fetch(:reserved_words    , self.class::WRITE_DIRECTIVE[:reserved_words      ])
          identifier_format = directive.fetch(:identifier_format , self.class::WRITE_DIRECTIVE[:identifier_format   ])
          keyword_format    = directive.fetch(:keyword_format    , self.class::WRITE_DIRECTIVE[:keyword_format      ])
          type_keyword      = directive.fetch(:type_keyword      , self.class::WRITE_DIRECTIVE[:keyword             ])

          keyword           = keyword_format    % {:keyword      => reserved_words[:type]              }
          identifier        = identifier_format % {:identifier   => _write_identifier_string(directive)}
          type_definition   = (@_type_definition.nil?)?  ""      :  _write_type_definition(directive)

          return (format % {:indent => indent, :keyword => keyword, :identifier => identifier, :type_definition => type_definition}).split(/\n/)
        end

      end
        
      module WriteIdentifier

        def _write_identifier_string(directive={})
          return @_identifier._write_string
        end

      end

      module WriteSimpleTypeDefinition

        def _write_type_definition(directive={})
          reserved_words  = directive.fetch(:reserved_words        , self.class::WRITE_DIRECTIVE[:reserved_words        ])
          format          = directive.fetch(:type_definition_format, self.class::WRITE_DIRECTIVE[:type_definition_format])
          return format % {:_is_ => reserved_words[:is], :type_definition => @_type_definition._write_string(directive)}
        end

      end

    end
  end
end

module RbVHDL::Ast

  module Declaration

    class IntegerType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      include RbVHDL::Writer::Declaration::Type::WriteSimpleTypeDefinition
    end

    class FloatingType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      include RbVHDL::Writer::Declaration::Type::WriteSimpleTypeDefinition
    end

    class PhysicalType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      def _write_type_definition(directive={})
        indent         = directive.fetch(:indent   , "" )
        format         = directive.fetch(:type_definition_format, self.class::WRITE_DIRECTIVE[:type_definition_format])
        keyword_format = directive.fetch(:keyword_format        , self.class::WRITE_DIRECTIVE[:keyword_format        ])
        reserved_words = directive.fetch(:reserved_words        , self.class::WRITE_DIRECTIVE[:reserved_words        ])
        type_directive = directive.dup
        type_directive[:primary_indent  ] = keyword_format % {keyword: ""} + " "
        type_directive[:secondary_indent] = type_directive[:primary_indent] 
        return format % {_is_: reserved_words[:is], type_definition: @_type_definition._write_string(type_directive)}
      end
    end

    class ArrayType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      include RbVHDL::Writer::Declaration::Type::WriteSimpleTypeDefinition
    end

    class EnumerationType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      include RbVHDL::Writer::Declaration::Type::WriteSimpleTypeDefinition
    end

    class RecordType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      def _write_type_definition(directive={})
        indent         = directive.fetch(:indent   , "" )
        format         = directive.fetch(:type_definition_format, self.class::WRITE_DIRECTIVE[:type_definition_format])
        keyword_format = directive.fetch(:keyword_format        , self.class::WRITE_DIRECTIVE[:keyword_format        ])
        reserved_words = directive.fetch(:reserved_words        , self.class::WRITE_DIRECTIVE[:reserved_words        ])
        type_directive = directive.dup
        type_directive[:field_indent] = keyword_format % {keyword: ""} + " "
        return format % {_is_: reserved_words[:is], type_definition: @_type_definition._write_string(type_directive)}
      end
    end
      
    class FileType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      include RbVHDL::Writer::Declaration::Type::WriteSimpleTypeDefinition
    end
      
    class AccessType
      WRITE_DIRECTIVE = {}.merge(RbVHDL::Writer::Declaration::Type::WRITE_DIRECTIVE)
      include RbVHDL::Writer::Declaration::Type::WriteLine
      include RbVHDL::Writer::Declaration::Type::WriteIdentifier
      include RbVHDL::Writer::Declaration::Type::WriteSimpleTypeDefinition
    end

  end
end
