require_relative "../models/assignment.rb"

class ProblemSolver
  attr_reader :cbc_model, :violations
  def initialize(problem_creator)
    @cbc_model = problem_creator.cbc_model
    @violations = problem_creator.violations
  end

  def cbc_problem
    @cbc_problem ||= cbc_model.to_problem
  end

  def solution
    @solution ||=
      begin
        cbc_problem.solve
        cbc_problem.proven_infeasible? ? Conflict.new(self) : Solution.new(self)
      end
  end
end
