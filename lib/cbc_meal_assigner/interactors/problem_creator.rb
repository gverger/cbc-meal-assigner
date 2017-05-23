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
  end

  def one_restaurant_per_order
    Order.each do |order|
      assignments = Assignment.for_order(order)
      assignment_variables = assignments.map(&:cbc_variable)
      cbc_model.enforce(one_assignment: assignment_variables.inject(:+) == 1)
    end
  end

  def to_s
    cbc_model.to_s
  end
end
