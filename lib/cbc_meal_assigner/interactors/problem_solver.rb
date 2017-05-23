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
        raise "Infeasible!" if cbc_problem.proven_infeasible?
        Solution.new(cbc_problem)
      end
  end
end
