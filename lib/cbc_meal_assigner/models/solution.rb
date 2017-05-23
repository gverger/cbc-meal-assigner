require_relative "assignments_list.rb"

class Solution
  attr_reader :assignments
  def initialize(cbc_problem)
    @assignments = Assignment.all.select do |assignment|
      cbc_problem.value_of(assignment.cbc_variable) == 1
    end
  end

  def to_s
    AssignmentList.new(assignments).to_s
  end
end
