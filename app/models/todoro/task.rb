module Todoro
  class Task < ApplicationRecord
    belongs_to :task_list
    has_many :reminders, dependent: :destroy

    validates :title, presence: true
    validates :description, presence: true
    validates :status, presence: true, inclusion: { in: %w[pending completed] }

    enum status: { pending: "pending", completed: "completed" }

    after_create :set_default_reminders

    private

    def set_default_reminders
      reminders.create(remind_at: expiry_date - 1.hour)
      reminders.create(remind_at: expiry_date - 1.day)
    end
  end
end
