module Todoro
  class TaskList < ApplicationRecord
    belongs_to :taskable, polymorphic: true
  end
end
