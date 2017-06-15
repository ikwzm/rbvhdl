module RbVHDL::Ast

  class Interface

    WRITE_DIRECTIVE = {
      :keyword               => "",
      :format                => "%{indent}%{keyword}%{identifier} %{mode}%{type}%{value}%{separator}",
      :keyword_format        => "%<keyword>-10s",
      :identifier_format     => "%{identifier}",
      :identifier_separator  => ",",
      :mode_format           => ": %{mode} ", 
      :type_format           => "%{type}",
      :value_format          => " := %{expression}",
    }
    
    def _write_line(directive={})
      indent               = directive.fetch(:indent   , "" )
      separator            = directive.fetch(:separator, ";")
      format               = directive.fetch(:format              , self.class::WRITE_DIRECTIVE[:format              ])
      keyword_format       = directive.fetch(:keyword_format      , self.class::WRITE_DIRECTIVE[:keyword_format      ])
      identifier_format    = directive.fetch(:identifier_format   , self.class::WRITE_DIRECTIVE[:identifier_format   ])
      mode_format          = directive.fetch(:mode_format         , self.class::WRITE_DIRECTIVE[:mode_format         ])
      type_format          = directive.fetch(:type_format         , self.class::WRITE_DIRECTIVE[:type_format         ])
      value_format         = directive.fetch(:value_format        , self.class::WRITE_DIRECTIVE[:value_format        ])
      keyword              = keyword_format    % {:keyword    => self.class::WRITE_DIRECTIVE[:keyword]}
      identifier           = identifier_format % {:identifier => _write_identifier_string(directive)  }
      mode                 = mode_format       % {:mode       => _write_mode_string(directive)        }
      type                 = type_format       % {:type       => _write_type_string(directive)        }
      value                = (@_static_expression.nil?)?  "" : value_format % {:expression => @_static_expression._write_string}
      return [ format % {indent: indent, keyword: keyword, identifier: identifier, mode: mode, type: type, value: value, separator: separator} ]
    end

    def _write_identifier_string(directive={})
      identifier_separator = directive.fetch(:identifier_separator, self.class::WRITE_DIRECTIVE[:identifier_separator])
      return @_identifier_list.map{|identifier| identifier._write_string}.join(identifier_separator)
    end

    def _write_mode_string(directive={})
      return (@_mode.nil?)?  "" : @_mode.to_s
    end

    def _write_type_string(directive={})
      return @_subtype_indication._write_string
    end
  end
end

require_relative 'interface/constant'
require_relative 'interface/signal'
require_relative 'interface/variable'
require_relative 'interface/file'

