module RbVHDL::Ast
  class Association
    module Methods

      def self._add_association(list, associations)
        if    associations.class == Array then
          associations.each_with_index do |actual, formal|
            list.push(RbVHDL::Ast.association(self, formal, actual))
          end
        elsif associations.class == Hash then
          associations.each_pair do |formal, actual|
            list.push(RbVHDL::Ast.association(self, formal, actual))
          end
        else
            list.push(RbVHDL::Ast.association(self, 0     , associations  ))
        end
      end

      module Generic
        def _generic_association(formal, actual)
          association = RbVHDL::Ast.association(self, formal, actual)
          @_generic_association_list.push(association)
          return association
        end
        def _add_generic_associations(associations)
          RbVHDL::Ast::Association::Methods._add_association(@_generic_association_list, associations)
        end
      end

      module Port
        def _port_association(formal, actual)
          association = RbVHDL::Ast.association(self, formal, actual)
          @_port_association_list.push(association)
          return association
        end
        def _add_port_associations(associations)
          RbVHDL::Ast::Association::Methods._add_association(@_port_association_list, associations)
        end
      end

      module Parameter
        def _parameter_association(formal, actual)
          association = RbVHDL::Ast.association(self, formal, actual)
          @_parameter_association_list.push(association)
          return association
        end
        def _add_parameter_associations(associations)
          RbVHDL::Ast::Association::Methods._add_association(@_parameter_association_list, associations)
        end
      end

    end
  end
end
