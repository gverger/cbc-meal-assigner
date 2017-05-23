require "ruby-cbc"

class ProblemCreator
  attr_reader :cbc_model

  def problem
    @cbc_model = Cbc::Model.new
    create_variables
    create_constraints
    cbc_model
  end

  def create_variables
    Assignment.each do |assignment|
      # Var == 1 --> assignment is chosen
      # Var == 0 --> assignment is not chosen
      assignment.cbc_variable = cbc_model.bin_var(name: assignment.id)
    end
  end

  def create_constraints
    one_restaurant_per_order
    not_same_restaurant_twice
    restaurant_capacities
    dont_assign_past_restaurants
  end

  def one_restaurant_per_order
    Order.each do |order|
      assignments = Assignment.for_order(order)
      assignment_variables = assignments.map(&:cbc_variable)
      cbc_model.enforce(one_assignment: assignment_variables.inject(:+) == 1)
    end
  end

  def not_same_restaurant_twice
    Restaurant.each do |restaurant|
      assignments = Assignment.for_restaurant(restaurant)
      assignments.group_by { |a| a.order.client }.each do |client, assignments|
        assignment_variables = assignments.map(&:cbc_variable)
        cbc_model.enforce(same_restaurant: assignment_variables.inject(:+) <= 1)
      end
    end
  end

  def restaurant_capacities
    Restaurant.each do |restaurant|
      assignments = Assignment.for_restaurant(restaurant)
      assignments.group_by(&:date).each do |_date, assignments_for_date|
        terms = assignments_for_date.map do |assignment|
          assignment.order_headcount * assignment.cbc_variable
        end
        cbc_model.enforce(restaurant_capacity: terms.inject(:+) <= restaurant.capacity)
      end
    end
  end

  def dont_assign_past_restaurants
    PastAssignment.each do |past_assignment|
      assignments_to_avoid = past_assignment.matching_assignments
      assignments_to_avoid.each do |assignment|
        cbc_model.enforce(assignment.cbc_variable == 0)
      end
    end
  end

  def to_s
    cbc_model.to_s
  end
end
