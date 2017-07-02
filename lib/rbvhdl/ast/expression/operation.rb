module RbVHDL::Ast

  def self.define_operator(type, operator, class_name, apply_name, parent_class_name, operand_apply_name_list)

    expression_class = self.const_get(:Expression)
    if type == :unary then
      operation_class = expression_class.const_set(class_name, Class.new(expression_class.const_get(parent_class_name)) do |klass|
        attr_accessor :_operand
        def initialize(expr)
          super()
          @_operand = [expr]
        end
      end )
    else
      operation_class = expression_class.const_set(class_name, Class.new(expression_class.const_get(parent_class_name)) do |klass|
        attr_accessor :_operand
        def initialize(l_expr, r_expr)
          super()
          @_operand = [l_expr, r_expr]
        end
      end )
    end

    operation_class.const_set(:OPERATOR, operator)
    operation_class.const_set(:TYPE    , type    )

    if    type == :unary then
      operand_apply_method = self.method(operand_apply_name_list[0])
      define_method(apply_name, Proc.new do |operand|
        return operation_class.new(operand_apply_method.call(operand))
      end)
      module_function(apply_name)

    elsif type == :binary then
      l_apply_method = self.method(operand_apply_name_list[0])
      r_apply_method = self.method(operand_apply_name_list[1])
      define_method(apply_name, Proc.new do |l, r|
        return operation_class.new(l_apply_method.call(l), r_apply_method.call(r))
      end)
      module_function(apply_name)

    elsif type == :polynomial then
      l_apply_method = self.method(operand_apply_name_list[0])
      r_apply_method = self.method(operand_apply_name_list[1])
      define_method(apply_name, Proc.new do |*operands|
        if    operands.size >  2 then
          r = operands.pop
          return operation_class.new(self.method(apply_name).call(*operands), r_apply_method.call(r))
        elsif operands.size == 2 then
          l = operands[0]
          r = operands[1]
          return operation_class.new((l.class == operation_class) ? l : l_apply_method.call(l),
                                     (r.class == operation_class) ? r : r_apply_method.call(r))
        else
          raise ArgumentError, "#{self.inspect}.#{__method__}(#{operands.inspect})"
        end
      end)
      module_function(apply_name)

    end
  end
  #
  # logical_expression  : relation
  #                     | relation { "and"  relation }
  #                     | relation [ "nand" relation ]
  #                     | relation { "or"   relation }
  #                     | relation [ "nor"  relation ]
  #                     | relation { "xor"  relation }
  #                     | relation { "xnor" relation }
  #
  #              | type      |operator|      class_name      |       apply_name       | parent_class_name |     operand_apply_name_list             |
  #--------------|-----------|--------|----------------------|------------------------|-------------------|-----------------------------------------|
  define_operator(:polynomial, :and   , :LogicalAnd          , :logical_and           , :LogicalExpression, [:relation, :relation]                  )
  define_operator(:binary    , :nand  , :LogicalNand         , :logical_nand          , :LogicalExpression, [:relation, :relation]                  )
  define_operator(:polynomial, :or    , :LogicalOr           , :logical_or            , :LogicalExpression, [:relation, :relation]                  )
  define_operator(:binary    , :nor   , :LogicalNor          , :logical_nor           , :LogicalExpression, [:relation, :relation]                  )
  define_operator(:polynomial, :xor   , :LogicalXor          , :logical_xor           , :LogicalExpression, [:relation, :relation]                  )
  define_operator(:polynomial, :xnor  , :LogicalXnor         , :logical_xnor          , :LogicalExpression, [:relation, :relation]                  )
  #
  # relation            : shift_expression
  #                     | shift_expression "="  shift_expression
  #                     | shift_expression "/=" shift_expression
  #                     | shift_expression "<"  shift_expression
  #                     | shift_expression "<=" shift_expression
  #                     | shift_expression ">"  shift_expression
  #                     | shift_expression ">=" shift_expression
  #
  #              | type      |operator|      class_name      |       apply_name       | parent_class_name |     operand_apply_name_list             |
  #--------------|-----------|--------|----------------------|------------------------|-------------------|-----------------------------------------|
  define_operator(:binary    , :"="   , :Equal               , :equal                 , :Relation         , [:shift_expression, :shift_expression]  )
  define_operator(:binary    , :"/="  , :NotEqual            , :not_equal             , :Relation         , [:shift_expression, :shift_expression]  )
  define_operator(:binary    , :"<"   , :LessThan            , :less_than             , :Relation         , [:shift_expression, :shift_expression]  )
  define_operator(:binary    , :"<="  , :LessThanEqual       , :less_than_equal       , :Relation         , [:shift_expression, :shift_expression]  )
  define_operator(:binary    , :">"   , :GreaterThan         , :greater_than          , :Relation         , [:shift_expression, :shift_expression]  )
  define_operator(:binary    , :">="  , :GreaterThanEqual    , :greater_than_equal    , :Relation         , [:shift_expression, :shift_expression]  )
  #
  # shift_expression    : simple_expression
  #                     | simple_expression "sll" simple_expression
  #                     | simple_expression "srl" simple_expression
  #                     | simple_expression "sla" simple_expression
  #                     | simple_expression "sra" simple_expression
  #                     | simple_expression "rol" simple_expression
  #                     | simple_expression "ror" simple_expression
  #
  #              | type      |operator|      class_name      |       apply_name       | parent_class_name |     operand_apply_name_list             |
  #--------------|-----------|--------|----------------------|------------------------|-------------------|-----------------------------------------|
  define_operator(:binary    , :"sll" , :ShiftLeftLogical    , :shift_left_logical    , :ShiftExpression  , [:simple_expression, :simple_expression])
  define_operator(:binary    , :"srl" , :ShiftRightLogical   , :shift_right_logical   , :ShiftExpression  , [:simple_expression, :simple_expression])
  define_operator(:binary    , :"sla" , :ShiftLeftArithmetic , :shift_left_arithmetic , :ShiftExpression  , [:simple_expression, :simple_expression])
  define_operator(:binary    , :"sra" , :ShiftRightArithmetic, :shift_right_arithmetic, :ShiftExpression  , [:simple_expression, :simple_expression])
  define_operator(:binary    , :"rol" , :RotateLeft          , :rotate_left           , :ShiftExpression  , [:simple_expression, :simple_expression])
  define_operator(:binary    , :"ror" , :RotateRight         , :rotate_right          , :ShiftExpression  , [:simple_expression, :simple_expression])
  #
  # simple_expression   :  ["+"|"-"] term {( "+" | "-" | "&") term}
  #
  #              | type      |operator|      class_name      |       apply_name       | parent_class_name |     operand_apply_name_list             |
  #--------------|-----------|--------|----------------------|------------------------|-------------------|-----------------------------------------|
  define_operator(:unary     , :"+"   , :UnaryPlus           , :unary_plus            , :SimpleExpression , [:term]                                 )
  define_operator(:unary     , :"-"   , :UnaryMinus          , :unary_minus           , :SimpleExpression , [:term]                                 )
  define_operator(:polynomial, :"+"   , :Addition            , :addition              , :SimpleExpression , [:simple_expression, :simple_expression])
  define_operator(:polynomial, :"-"   , :Subtraction         , :subtraction           , :SimpleExpression , [:simple_expression, :simple_expression])
  define_operator(:polynomial, :"&"   , :Concatenation       , :concatenation         , :SimpleExpression , [:simple_expression, :simple_expression])
  #
  # term                :  factor {("*" | "/" | "mod" | "rem") factor}
  #
  #              | type      |operator|      class_name      |       apply_name       | parent_class_name |     operand_apply_name_list             |
  #--------------|-----------|--------|----------------------|------------------------|-------------------|-----------------------------------------|
  define_operator(:polynomial, :"*"   , :Multiplication      , :multiplication        , :Term             , [:term, :term]                          )
  define_operator(:polynomial, :"/"   , :Division            , :division              , :Term             , [:term, :term]                          )
  define_operator(:polynomial, :mod   , :Modulo              , :modulo                , :Term             , [:term, :term]                          )
  define_operator(:polynomial, :rem   , :Remainder           , :remainder             , :Term             , [:term, :term]                          )

  # factor              :  primary
  #                     |  primary "**" primary
  #                     |  "abs"  primary
  #                     |  "not"  primary
  #                     |  "and"  primary
  #                     |  "nand" primary
  #                     |  "or"   primary
  #                     |  "nor"  primary
  #                     |  "xor"  primary
  #                     |  "xnor" primary
  #
  #              | type      |operator|      class_name      |       apply_name       | parent_class_name |     operand_apply_name_list             |
  #--------------|-----------|--------|----------------------|------------------------|-------------------|-----------------------------------------|
  define_operator(:binary    , :"**"  , :Exponentiation      , :exponentiation        , :Factor           , [:primary, :primary]                    )
  define_operator(:unary     , :abs   , :Abs                 , :abs                   , :Factor           , [:primary]                              )
  define_operator(:unary     , :not   , :Not                 , :not                   , :Factor           , [:primary]                              )
  define_operator(:unary     , :and   , :ReductionAnd        , :reduction_and         , :Factor           , [:primary]                              )
  define_operator(:unary     , :nand  , :ReductionNand       , :reduction_nand        , :Factor           , [:primary]                              )
  define_operator(:unary     , :or    , :ReductionOr         , :reduction_or          , :Factor           , [:primary]                              )
  define_operator(:unary     , :nor   , :ReductionNor        , :reduction_nor         , :Factor           , [:primary]                              )
  define_operator(:unary     , :xor   , :ReductionXor        , :reduction_xor         , :Factor           , [:primary]                              )
  define_operator(:unary     , :xnor  , :ReductionXnor       , :reduction_xnor        , :Factor           , [:primary]                              )
    
end
