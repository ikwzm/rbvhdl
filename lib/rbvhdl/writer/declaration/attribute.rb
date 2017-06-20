module RbVHDL::Ast

  module Declaration

    class AttributeDecl

      WRITE_DIRECTIVE = {
        :keyword              => "attribute",
        :format               => "%{indent}%{keyword} %{identifier} :  %{type};",
        :keyword_format       => "%<keyword>-9s",
        :identifier_format    => "%{identifier}",
        :identifier_align     => true,
        :type_format          => "%{type}",
      }

      def _write_line(directive={})
        indent            = directive.fetch(:indent   , "")
        format            = directive.fetch(:format           , WRITE_DIRECTIVE[:format            ])
        keyword_format    = directive.fetch(:keyword_format   , WRITE_DIRECTIVE[:keyword_format    ])
        identifier_format = directive.fetch(:identifier_format, WRITE_DIRECTIVE[:identifier_format ])
        type_format       = directive.fetch(:type_format      , WRITE_DIRECTIVE[:type_format       ])
        attribute_keyword = directive.fetch(:attribute_keyword, WRITE_DIRECTIVE[:keyword           ])
        keyword           = keyword_format    % {:keyword    => attribute_keyword                  }
        identifier        = identifier_format % {:identifier => _write_identifier_string(directive)}
        type              = type_format       % {:type       => _write_type_string(directive)      }
        return [ format % {indent: indent, keyword: keyword, identifier: identifier, type: type} ]
      end

      def _write_identifier_string(directive={})
        return @_identifier._write_string
      end

      def _write_type_string(directive={})
        return @_type_mark._write_string
      end
    end

    class AttributeSpec

      WRITE_DIRECTIVE = {
        :keyword              => "attribute",
        :format               => "%{indent}%{keyword} %{identifier} of %{entity_name} : %{entity_class} is %{value};",
        :keyword_format       => "%<keyword>-9s",
        :identifier_format    => "%{identifier}",
        :identifier_align     => true,
        :entity_name_format   => "%{entity_name}",
        :entity_class_format  => "%{entity_class}",
        :value_format         => "%{expression}",
      }

      def _write_line(directive={})
        indent              = directive.fetch(:indent   , "")
        format              = directive.fetch(:format             , WRITE_DIRECTIVE[:format             ])
        keyword_format      = directive.fetch(:keyword_format     , WRITE_DIRECTIVE[:keyword_format     ])
        identifier_format   = directive.fetch(:identifier_format  , WRITE_DIRECTIVE[:identifier_format  ])
        entity_name_format  = directive.fetch(:entity_name_format , WRITE_DIRECTIVE[:entity_name_format ])
        entity_class_format = directive.fetch(:entity_class_format, WRITE_DIRECTIVE[:entity_class_format])
        value_format        = directive.fetch(:value_format       , WRITE_DIRECTIVE[:value_format       ])
        attribute_keyword   = directive.fetch(:attribute_keyword  , WRITE_DIRECTIVE[:keyword            ])
        keyword             = keyword_format      % {:keyword      => attribute_keyword                  }
        identifier          = identifier_format   % {:identifier   => _write_identifier_string(directive)}
        entity_name         = entity_name_format  % {:entity_name  => @_entity_name_list.map{|name| name._write_string}.join(',')}
        entity_class        = entity_class_format % {:entity_class => @_entity_class.to_s}
        value               = value_format        % {:expression   => @_value_expression._write_string }
        return [ format % {indent: indent, keyword: keyword, identifier: identifier, entity_name: entity_name, entity_class: entity_class, value: value } ]
      end

      def _write_identifier_string(directive={})
        return @_identifier._write_string
      end
    end

  end
end
