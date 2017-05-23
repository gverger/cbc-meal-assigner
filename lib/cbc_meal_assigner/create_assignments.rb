require_relative "populate.rb"
require_relative "models.rb"

def create_assignments
  Order.each do |order|
    create_assignments_for_order(order)
  end
end

def create_assignments_for_order(order)
  Restaurant.each do |restaurant|
    Assignment.create(order, restaurant) if order.headcount <= restaurant.capacity
  end
end
