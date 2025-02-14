module Todoro
  class Reminder < ApplicationRecord
    belongs_to :task
  end
end
