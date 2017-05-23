class Conflict
  attr_reader :cbc_problem
  def initialize(cbc_problem)
    @cbc_problem = cbc_problem
  end

  def to_s
    "CONFLICT => \n" +
      cbc_problem.find_conflict.map(&:to_function_s).sort.join("\n")
  end
end
