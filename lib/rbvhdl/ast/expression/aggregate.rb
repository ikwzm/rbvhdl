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
        @_item_list = item_list
      end

      def _add_item!(item)
        @_item_list.push(item)
        return self
      end
    end

  end

  def self.aggregate_item(choices, expression)
    return RbVHDL::Ast::Expression::Aggregate::Item.new(RbVHDL::Ast.choices_or_nil(choices), RbVHDL::Ast.expression(expression))
  end

  def self.aggregate(items=nil)
    aggregate = RbVHDL::Ast::Expression::Aggregate.new([])
    if    items.nil?                                              then item_list = []
    elsif items.class == RbVHDL::Ast::Expression::Aggregate::Item then item_list = [items]
    elsif items.class == Array then
      if items.reject { |item| item.class == RbVHDL::Ast::Expression::Aggregate::Item }.count == 0 then
        item_list = items
      else
        item_list = nil
      end
    else
      item_list = nil
    end
    if item_list.nil? then
      raise ArgumentError, "#{self.inspect}.#{__method__}(#{items.inspect}:#{items.class})"
    end
    item_list.each do |item|
      aggregate._add_item!(item)
    end
    return aggregate
  end

end
