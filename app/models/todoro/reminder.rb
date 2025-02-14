module Todoro
  class Reminder < ApplicationRecord
    belongs_to :task

    validates :remind_at, presence: true
  end
end
