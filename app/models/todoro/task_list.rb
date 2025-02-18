module Todoro
  class TaskList < ApplicationRecord
    belongs_to :taskable, polymorphic: true
    has_many :tasks, -> { order(created_at: :desc) }, dependent: :destroy

    validates :name, presence: true
  end
end
