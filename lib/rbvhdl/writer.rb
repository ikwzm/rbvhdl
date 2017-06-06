require_relative 'ast'
module RbVHDL

  module Writer
    def self._write_directive(klass, directive)
      klass.instance_variable_set(:@_write_directive, directive)
      klass.class_eval do
        def self._write_directive
          return @_write_directive
        end
      end
    end
    class Directive
      attr_reader :directive
      def initialize(directive)
        @directive = directive
      end
      def fetch(klass, keyword, default=nil)
        if default.nil? then
          return @directive.fetch(keyword, klass.class._write_directive[keyword])
        else
          return @directive.fetch(keyword, klass.class._write_directive.fetch(keyword, default))
        end
      end
      def clone
        return Directive.new(@directive.clone)
      end
    end
    EmptyDirective = Directive.new({})
  end
  
  require_relative 'writer/identifier'
  require_relative 'writer/label'
  require_relative 'writer/expression'
  require_relative 'writer/type'
  require_relative 'writer/statement'
  require_relative 'writer/declaration'
  require_relative 'writer/interface'
  require_relative 'writer/association'
  require_relative 'writer/library_clause'
  require_relative 'writer/design_unit'
end
