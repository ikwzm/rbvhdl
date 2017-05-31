require_relative 'logical_expression'
require_relative 'relation'
require_relative 'shift_expression'
require_relative 'simple_expression'
require_relative 'term'
require_relative 'factor'
require_relative 'primary'

module RbVHDL::Ast

  def self.binary_operation(name, operator, apply_name, self_class_name, l_apply_name, r_apply_name)
    expression_class = self.const_get(:Expression)
    expression_class.const_set(name, Class.new(expression_class.const_get(self_class_name)) do |klass|
      attr_accessor :_l_expr, :_r_expr
      def initialize(l_expr, r_expr)
        super()
        @_l_expr = l_expr
        @_r_expr = r_expr
      end
    end )
    l_apply_method   = self.method(l_apply_name)
    r_apply_method   = self.method(r_apply_name)
    operation_class  = expression_class.const_get(name)
    operation_class.const_set(:OPERATOR, operator)
    define_method(apply_name, Proc.new do |l, r|
      return operation_class.new(l_apply_method.call(l), r_apply_method.call(r))
    end)
    module_function(apply_name)
  end

  def self.unary_operation(name, operator, apply_name, self_class_name, arg_apply_name)
    expression_class = self.const_get(:Expression)
    expression_class.const_set(name, Class.new(expression_class.const_get(self_class_name)) do |klass|
      attr_accessor :_expr
      def initialize(expr)
        super()
        @_expr = expr
      end
    end )
    arg_apply_method = self.method(arg_apply_name)
    operation_class  = expression_class.const_get(name)
    operation_class.const_set(:OPERATOR, operator)
    define_method(apply_name, Proc.new do |expr|
      return operation_class.new(arg_apply_method.call(expr))
    end)
    module_function(apply_name)
  end

  # logical_expression  : relation
  #                     | relation "and"  relation
  #                     | relation "nand" relation
  #                     | relation "or"   relation
  #                     | relation "nor"  relation
  #                     | relation "xor"  relation
  #                     | relation "xnor" relation
  binary_operation(:LogicalAnd         , :and  , :logical_and            , :LogicalExpression, :relation, :relation)
  binary_operation(:LogicalNand        , :nand , :logical_nand           , :LogicalExpression, :relation, :relation)
  binary_operation(:LogicalOr          , :or   , :logical_or             , :LogicalExpression, :relation, :relation)
  binary_operation(:LogicalNor         , :nor  , :logical_nor            , :LogicalExpression, :relation, :relation)
  binary_operation(:LogicalXor         , :xor  , :logical_xor            , :LogicalExpression, :relation, :relation)
  binary_operation(:LogicalXnor        , :xnor , :logical_xnor           , :LogicalExpression, :relation, :relation)

  # relation            : shift_expression
  #                     | shift_expression "="  shift_expression
  #                     | shift_expression "/=" shift_expression
  #                     | shift_expression "<"  shift_expression
  #                     | shift_expression "<=" shift_expression
  #                     | shift_expression ">"  shift_expression
  #                     | shift_expression ">=" shift_expression
  binary_operation(:Equal               , :"=" , :equal                  , :Relation, :shift_expression, :shift_expression)
  binary_operation(:NotEqual            , :"/=", :not_equal              , :Relation, :shift_expression, :shift_expression)
  binary_operation(:LessThan            , :"<" , :less_than              , :Relation, :shift_expression, :shift_expression)
  binary_operation(:LessThanEqual       , :"<=", :less_than_equal        , :Relation, :shift_expression, :shift_expression)
  binary_operation(:GreaterThan         , :">" , :greater_than           , :Relation, :shift_expression, :shift_expression)
  binary_operation(:GreaterThanEqual    , :">=", :greater_than_equal     , :Relation, :shift_expression, :shift_expression)

  # shift_expression    : simple_expression
  #                     | simple_expression "sll" simple_expression
  #                     | simple_expression "srl" simple_expression
  #                     | simple_expression "sla" simple_expression
  #                     | simple_expression "sra" simple_expression
  #                     | simple_expression "rol" simple_expression
  #                     | simple_expression "ror" simple_expression
  binary_operation(:ShiftLeftLogical    , :"sll", :shift_left_logical    , :ShiftExpression, :simple_expression, :simple_expression)
  binary_operation(:ShiftRightLogical   , :"srl", :shift_right_logical   , :ShiftExpression, :simple_expression, :simple_expression)
  binary_operation(:ShiftLeftArithmetic , :"sla", :shift_left_arithmetic , :ShiftExpression, :simple_expression, :simple_expression)
  binary_operation(:ShiftRightArithmetic, :"sra", :shift_right_arithmetic, :ShiftExpression, :simple_expression, :simple_expression)
  binary_operation(:RotateLeft          , :"rol", :rotate_left           , :ShiftExpression, :simple_expression, :simple_expression)
  binary_operation(:RotateRight         , :"ror", :rotate_right          , :ShiftExpression, :simple_expression, :simple_expression)

  # simple_expression   :  ["+"|"-"]  term
  #                     |  ["+"|"-"]  term "+" term
  #                     |  ["+"|"-"]  term "-" term
  #                     |  ["+"|"-"]  term "&" term
  unary_operation( :UnaryPlus           , :"+"  , :unary_plus            , :SimpleExpression, :term)
  unary_operation( :UnaryMinus          , :"-"  , :unary_minus           , :SimpleExpression, :term)
  binary_operation(:Addition            , :"+"  , :addition              , :SimpleExpression, :unary_term, :term)
  binary_operation(:Subtraction         , :"-"  , :subtraction           , :SimpleExpression, :unary_term, :term)
  binary_operation(:Concatenation       , :"&"  , :concatenation         , :SimpleExpression, :unary_term, :term)

  # term                :  factor
  #                     |  factor "*"   factor
  #                     |  factor "/"   factor
  #                     |  factor "mod" factor
  #                     |  factor "rem" factor
  binary_operation(:Multiplication      , :"*"  , :multiplication        , :Term, :factor, :factor)
  binary_operation(:Division            , :"/"  , :division              , :Term, :factor, :factor)
  binary_operation(:Modulo              , :mod  , :modulo                , :Term, :factor, :factor)
  binary_operation(:Remainder           , :rem  , :remainder             , :Term, :factor, :factor)

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
  binary_operation(:Exponentiation      , :"**" , :exponentiation        , :Factor, :primary, :primary)
  unary_operation( :Abs                 , :abs  , :abs                   , :Factor, :primary)
  unary_operation( :Not                 , :not  , :not                   , :Factor, :primary)
  unary_operation( :ReductionAnd        , :and  , :reduction_and         , :Factor, :primary)
  unary_operation( :ReductionNand       , :nand , :reduction_nand        , :Factor, :primary)
  unary_operation( :ReductionOr         , :or   , :reduction_or          , :Factor, :primary)
  unary_operation( :ReductionNor        , :nor  , :reduction_nor         , :Factor, :primary)
  unary_operation( :ReductionXor        , :xor  , :reduction_xor         , :Factor, :primary)
  unary_operation( :ReductionXnor       , :xnor , :reduction_xnor        , :Factor, :primary)
    
end
