require_relative 'primary'
require_relative 'choices'

module RbVHDL::Ast

  class Expression
    # aggregate           : "(" aggregate_items ")"
    # aggregate_items     : aggregate_item
    #                     | aggregate_item "," aggregate_items
    #
    # aggregate_item      : expression
    #                     | choices "=>" expression
    class Aggregate < Primary
      class Item
        attr_reader    :_choices
        attr_reader    :_expression
        def initialize(choices, expression)
          @_choices    = choices
          @_expression = expression
        end
      end

      attr_reader   :_item_list
      def initialize(item_list)
        super()
        @_item_list = _item_list
      end

      def _add_item(item)
        @_item_list.push(item)
        return self
      end
    end

  end

  def self.aggregate_item(choice_list, expression)
    if choice_list.nil? then
      choices = nil
    else
      choices = RbVHDL::Ast.choices(choice_list)
    end
    return RbVHDL::Ast::Expression::Aggregate::Item.new(choices, RbVHDL::Ast.expression(expression))
  end

  def self.aggregate(items=nil)
    aggregate = RbVHDL::Ast::Expression::Aggregate.new([])
    if items.nil? then
      return aggregate
    elsif items.class == Array then
      items.each do |item|
        if item.class == RbVHDL::Ast::Expression::Aggregate::Item then
          aggregate._add_item(item)
        else
          raise "abort #{self.class}.#{__method__}(#{items}:#{items.class}): Illegal class"
        end
      end
      return aggregate
    elsif items.class = RbVHDL::Ast::Expression::Aggregate::Item then
      return aggregate._add_item(items)
    else
      raise "abort #{self.class}.#{__method__}(#{items}:#{items.class}): Illegal class"
    end
  end

end
