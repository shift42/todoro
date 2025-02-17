module Todoro
  class TaskAssignment < ApplicationRecord
    belongs_to :task, class_name: "Todoro::Task"
    belongs_to :assignee, polymorphic: true

    validate :assignee_must_be_taskable

    private

    def assignee_must_be_taskable
      unless Todoro.assignable_models.include?(assignee_type)
        errors.add(:assignee, "#{assignee_type} is not a registered taskable model")
      end
    end
  end
end
