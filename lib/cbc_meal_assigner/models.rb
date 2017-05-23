%i(order client assignment restaurant).each do |model|
  require_relative "models/#{model}.rb"
end
