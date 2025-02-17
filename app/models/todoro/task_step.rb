module Todoro
  class TaskStep < ApplicationRecord
    belongs_to :task, class_name: "Todoro::Task"

    validates :title, presence: true
  end
end
