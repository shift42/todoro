module Todoro
  class Task < ApplicationRecord
    belongs_to :task_list
    has_many :reminders, dependent: :destroy
    has_many :task_steps, class_name: "Todoro::TaskStep", dependent: :destroy

    has_many :task_assignments, dependent: :destroy
    has_many :assignees, through: :task_assignments, source: :assignee


    validates :title, presence: true
    validates :status, presence: true, inclusion: { in: %w[pending completed] }

    enum :status, { pending: "pending", completed: "completed" }

    after_create :set_default_reminders

    accepts_nested_attributes_for :task_steps

    def complete!
      update(status: "completed", completed_at: Time.zone.now)
    end

    def assign_to(assignee)
      task_assignments.find_or_create_by(assignee: assignee)
    end

    def unassign(assignee)
      task_assignments.where(assignee: assignee).destroy_all
    end

    private

    def set_default_reminders
      return unless due_date

      reminders.create(remind_at: due_date - 1.hour)
      reminders.create(remind_at: due_date - 1.day)
    end
  end
end
