module Todoro
  module TaskableAssignee
    extend ActiveSupport::Concern

    included do
      has_many :task_assignments, as: :assignee, class_name: "Todoro::TaskAssignment", dependent: :destroy
      has_many :tasks, through: :task_assignments, source: :task
    end

    class_methods do
      def taskable_assignee
        Todoro.assignable_models << self.name unless Todoro.assignable_models.include?(self.name)
      end
    end
  end
end
