require_relative "assignments_list.rb"

class Solution
  attr_reader :assignments
  def initialize(assignments)
    @assignments = assignments
  end

  def to_s
    AssignmentList.new(assignments).to_s
  end
end
