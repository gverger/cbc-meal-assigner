require_relative "client.rb"
require_relative "../utils/collection.rb"

class Order
  extend Collection

  attr_reader :reference, :client, :date
  def initialize(reference, client_name, date)
    @reference = reference
    @client = Client[client_name]
    @date = date
  end

  alias id reference

  def headcount
    client.headcount
  end

  def to_s
    "#{reference}(#{headcount})"
  end
end
