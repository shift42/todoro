module Todoro
  class TaskList < ApplicationRecord
    belongs_to :taskable, polymorphic: true
    has_many :tasks, dependent: :destroy

    validates :name, presence: true
  end
end
