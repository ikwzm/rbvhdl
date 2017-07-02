require_relative '../declaration/write_declarative_item_list'

module RbVHDL::Ast

  module Declaration

    class PackageBody

      WRITE_DIRECTIVE = {
        :reserved_words            => RbVHDL::Writer::RESERVED_WORDS,
        :package_body_begin_format => "%{indent}%{_package_} %{_body_} %{identifier} %{_is_}",
        :package_body_end_format   => "%{indent}%{_end_} %{identifier};",
      }.merge( RbVHDL::Writer::Declaration::WRITE_DIRECTIVE )

      def _write_line(directive={})
        write_line  = []
        indent      = directive.fetch(:indent, "")
        identifier  = @_identifier._write_string
    
        reserved_words            = directive.fetch(:reserved_words           , WRITE_DIRECTIVE[:reserved_words           ])
        package_body_begin_format = directive.fetch(:package_body_begin_format, WRITE_DIRECTIVE[:package_body_begin_format])
        package_body_end_format   = directive.fetch(:package_body_end_format  , WRITE_DIRECTIVE[:package_body_end_format  ])

        write_line.push   package_body_begin_format % {
          :indent     => indent,
          :_package_  => reserved_words[:package],
          :_body_     => reserved_words[:body],
          :identifier => identifier,
          :_is_       => reserved_words[:is],
        }

        write_line.concat _write_declarative_item_list(directive)

        write_line.push   package_body_end_format   % {
          :indent     => indent,
          :_end_      => reserved_words[:end],
          :_package_  => reserved_words[:package],
          :_body_     => reserved_words[:body],
          :identifier => identifier,
        }

        return write_line
      end
      include RbVHDL::Writer::Declaration::WriteDeclarativeItemList
    end

  end
end
