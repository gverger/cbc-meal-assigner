require "cbc_meal_assigner/version"
require "ruby-cbc"

module CbcMealAssigner
end

files = %w(
  create_assignments.rb
  models.rb
  populate.rb
  models/assignment.rb
  models/assignments_list.rb
  models/client.rb
  models/past_assignment.rb
  models/order.rb
  models/restaurant.rb
  models/solution.rb
  interactors/problem_creator.rb
  interactors/problem_solver.rb
)

files.each do |file|
  require File.expand_path("../cbc_meal_assigner/#{file}", __FILE__)
end
