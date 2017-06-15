module RbVHDL::Ast

  class Interface

    class Mode

      class In
        WRITE_DIRECTIVE = {:keyword => "in"}
        def _write_string(directive={})
          return directive.fetch(:in_keyword, self.class::WRITE_DIRECTIVE[:keyword])
        end
      end

      class Out
        WRITE_DIRECTIVE = {:keyword => "out"}
        def _write_string(directive={})
          return directive.fetch(:out_keyword, self.class::WRITE_DIRECTIVE[:keyword])
        end
      end

      class Inout
        WRITE_DIRECTIVE = {:keyword => "inout"}
        def _write_string(directive={})
          return directive.fetch(:inout_keyword, self.class::WRITE_DIRECTIVE[:keyword])
        end
      end
    end
  end
end

