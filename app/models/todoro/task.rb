module Todoro
  class Task < ApplicationRecord
    belongs_to :task_list
  end
end
