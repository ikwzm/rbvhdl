require_relative '../association/parameter'

module RbVHDL::Ast

  class Expression

    class SimpleName
      WRITE_DIRECTIVE = {:format => "%{name}"}

      def _write_string(directive={})
        format = directive.fetch(:format , WRITE_DIRECTIVE[:format ])
        return format % {name: @_name._write_string}
      end
    end

    class FunctionCall
      WRITE_DIRECTIVE = {
        :format                              => "%{name}%{parameter}",
        :parameter_format                    => "%{parameter}",
        :parameter_begin_format              => "(",
        :parameter_end_format                => ")",
        :parameter_association_indent        => "",
        :parameter_association_separator     => ", ",
        :parameter_association_formal_format => "%{formal} => ",
        :parameter_association_actual_format => "%{actual}",
      }.merge( RbVHDL::Writer::Association::Parameter::WRITE_DIRECTIVE ){|key, base_val, default_val| base_val}
      include  RbVHDL::Writer::Association::Parameter::WriteAssociation

      def _write_string(directive={})
        name   = @_name._write_string
        format           = directive.fetch(:format          , WRITE_DIRECTIVE[:format          ])
        parameter_format = directive.fetch(:parameter_format, WRITE_DIRECTIVE[:parameter_format])
        return format % {name: name, parameter: parameter_format % {parameter: _write_parameter_association.join}}
      end
    end
    
    class IndexedName
      WRITE_DIRECTIVE = {:format => "%{name}%{index}", :index_format => "(%{index_list})", :index_separator => ", "}

      def _write_string(directive={})
        name   = @_prefix._write_string
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {name: name, index: _write_index_string(directive)}
      end

      def _write_index_string(directive={})
        if @_index_list.size > 0 then
          index_format    = directive.fetch(:index_format   , WRITE_DIRECTIVE[:index_format   ])
          index_separator = directive.fetch(:index_separator, WRITE_DIRECTIVE[:index_separator])
          index_list      = @_index_list.map{ |index| index._write_string}.join(index_separator)
          return index_format % {index_list: index_list}
        else
          return ""
        end
      end
    end
  
    class SliceName
      WRITE_DIRECTIVE = {:format => "%{name}%{range}", :range_format =>"(%{range})"}

      def _write_string(directive={})
        name   = @_prefix._write_string
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {name: name, range: _write_range_string(directive)}
      end

      def _write_range_string(directive={})
        if @_range.nil? then
          return ""
        else
          range_format = directive.fetch(:range_format, WRITE_DIRECTIVE[:range_format])
          return range_format % {range: @_range._write_string}
        end
      end
    end
  
    class SelectedName
      WRITE_DIRECTIVE = {:format => "%{prefix}.%{suffix}"}

      def _write_string(directive={})
        format = directive.fetch(:format, WRITE_DIRECTIVE[:format])
        return format % {prefix: @_prefix._write_string, suffix: @_suffix._write_string}
      end
    end

    class All
      WRITE_DIRECTIVE = {:keyword => "all", :format => "%{keyword}"}
      
      def _write_string(directive={})
        format  = directive.fetch(:format , WRITE_DIRECTIVE[:format ])
        keyword = directive.fetch(:keyword, WRITE_DIRECTIVE[:keyword])
        return format % {keyword: keyword}
      end
    end

    class AttributeName
      WRITE_DIRECTIVE = {
        :format           => "%{name}%{signature?}'%{attribute}%{parameter?}",
        :signature_format => " %{signature} ",
        :parameter_format => "(%{expression})",
      }

      def _write_string(directive={})
        format           = directive.fetch(:format           , WRITE_DIRECTIVE[:format          ])
        signature_format = directive.fetch(:signature_format , WRITE_DIRECTIVE[:signature_format])
        parameter_format = directive.fetch(:parameter_format , WRITE_DIRECTIVE[:parameter_format])

        name      = @_name._write_string
        attribute = @_attribute._write_string
        signature = (@_signature. nil?)? "" : signature_format % {:signature  => @_signature._write_string }
        parameter = (@_expression.nil?)? "" : parameter_format % {:expression => @_expression._write_string}

        return format % {:name => name, :signature? => signature, :attribute => attribute, :parameter? => parameter}
      end
    end

  end
end
