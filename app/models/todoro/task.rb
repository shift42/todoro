module Todoro
  class Task < ApplicationRecord
    belongs_to :task_list
    has_many :reminders, dependent: :destroy
    has_many :task_steps, class_name: "Todoro::TaskStep", dependent: :destroy

    validates :title, presence: true
    validates :status, presence: true, inclusion: { in: %w[pending completed] }

    enum :status, { pending: "pending", completed: "completed" }

    after_create :set_default_reminders

    def complete!
      update(status: "completed", completed_at: Time.zone.now)
    end

    private

    def set_default_reminders
      return unless due_date

      reminders.create(remind_at: due_date - 1.hour)
      reminders.create(remind_at: due_date - 1.day)
    end
  end
end
