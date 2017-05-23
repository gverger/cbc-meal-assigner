require_relative "../utils/collection.rb"

class Assignment
  extend Collection

  attr_reader :id, :order, :restaurant
  def initialize(order, restaurant)
    @id = "#{order.reference}-#{restaurant.name}".to_sym
    @order = order
    @restaurant = restaurant
  end

  attr_accessor :cbc_variable

  def self.for_order(order)
    Assignment.all.select { |assignment| assignment.order == order }
  end

  def self.for_restaurant(restaurant)
    Assignment.all.select { |assignment| assignment.restaurant == restaurant }
  end

  def date
    order.date
  end

  def order_headcount
    order.headcount
  end

  def client
    order.client
  end

  def restaurant_capacity
    restaurant.capacity
  end

  def to_s
    "#{order} - #{restaurant}"
  end
end
