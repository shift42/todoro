module Todoro
  module Taskable
    extend ActiveSupport::Concern

    included do
      has_many :task_lists, as: :taskable, class_name: "Todoro::TaskList", dependent: :destroy
    end

    def tasks
      Todoro::Task.joins(:task_list).where(task_lists: { taskable_id: id, taskable_type: self.class.name })
    end

    def create_task_list(name)
      task_lists.create(name: name)
    end

    def add_task_to_list(task_list, title, description, expiry_date = nil)
      task_list.tasks.create(title: title, description: description, expiry_date: expiry_date, status: "pending")
    end
  end
end
