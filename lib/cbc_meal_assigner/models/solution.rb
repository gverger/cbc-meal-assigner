require_relative "assignments_list.rb"

class Solution
  attr_reader :problem_solver, :cbc_problem
  def initialize(problem_solver)
    @problem_solver = problem_solver
  end

  def cbc_problem
    problem_solver.cbc_problem
  end

  def assignments
    @assignments ||= Assignment.all.select do |assignment|
      cbc_problem.value_of(assignment.cbc_variable) == 1
    end
  end

  def violations
    @violations ||=
      problem_solver.violations&.select { |violation| cbc_problem.value_of(violation.slack_variable) > 0 }
  end

  def to_s
    result = AssignmentList.new(assignments).to_s
    return result unless violations && !violations.empty?

    violations.map do |violation|
      result += "\n#{violation.description} [#{violation.cost}] --> #{violation.cost * cbc_problem.value_of(violation.slack_variable)}"
    end
    result
  end
end
