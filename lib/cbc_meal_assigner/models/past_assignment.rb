class PastAssignment
  extend Collection

  attr_reader :client, :restaurant
  def initialize(client_name, restaurant_name)
    @client = Client[client_name]
    @restaurant = Restaurant[restaurant_name]
  end

  def matching_assignments
    Assignment.all.select do |assignment|
      assignment.client == client && assignment.restaurant == restaurant
    end
  end

  def id
    "#{client.name}-#{restaurant.name}".to_sym
  end

  def to_s
    "#{client.name}-#{restaurant.name}"
  end
end
