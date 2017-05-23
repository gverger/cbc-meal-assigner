require_relative "../models/assignment.rb"

class ProblemSolver
  attr_reader :cbc_model
  def initialize(cbc_model)
    @cbc_model = cbc_model
  end

  def cbc_problem
    @cbc_problem ||= cbc_model.to_problem
  end

  def solution
    @solution ||=
      begin
        cbc_problem.solve
        cbc_problem.proven_infeasible? ? Conflict.new(cbc_problem) : Solution.new(cbc_problem)
      end
  end
end
