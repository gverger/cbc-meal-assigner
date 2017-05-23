class AssignmentList
  attr_reader :assignments
  def initialize(assignments)
    @assignments = assignments
  end

  def to_s
    string = ""
    assignments.group_by { |assignment| assignment.order.date }.each do |date, assignments_on_date|
      string << "#{date}\n"
      assignments_on_date.each do |assignment|
        string << "  #{assignment}\n"
      end
    end
    string
  end
end
