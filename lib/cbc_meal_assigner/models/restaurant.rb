require_relative "../utils/collection.rb"

class Restaurant
  extend Collection

  attr_reader :name, :capacity
  def initialize(name, capacity)
    @name = name
    @capacity = capacity
  end

  alias id name

  def to_s
    "#{name}(#{capacity})"
  end
end
