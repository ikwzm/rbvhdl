module RbVHDL::Ast

  class Interface

    class Mode

      class In
        WRITE_DIRECTIVE = {:reserved_words => RbVHDL::Writer::RESERVED_WORDS}
        def _write_string(directive={})
          reserved_words = directive.fetch(:reserved_words, self.class::WRITE_DIRECTIVE[:reserved_words])
          return reserved_words[:in]
        end
      end

      class Out
        WRITE_DIRECTIVE = {:reserved_words => RbVHDL::Writer::RESERVED_WORDS}
        def _write_string(directive={})
          reserved_words = directive.fetch(:reserved_words, self.class::WRITE_DIRECTIVE[:reserved_words])
          return reserved_words[:out]
        end
      end

      class Inout
        WRITE_DIRECTIVE = {:reserved_words => RbVHDL::Writer::RESERVED_WORDS}
        def _write_string(directive={})
          reserved_words = directive.fetch(:reserved_words, self.class::WRITE_DIRECTIVE[:reserved_words])
          return reserved_words[:inout]
        end
      end
    end

  end
end
