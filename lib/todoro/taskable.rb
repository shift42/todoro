module Todoro
  module Taskable
    extend ActiveSupport::Concern

    included do
      has_many :task_lists, as: :taskable, class_name: "Todoro::TaskList", dependent: :destroy
      has_many :tasks, through: :task_lists, class_name: "Todoro::Task"

      after_initialize :ensure_taskable_registered
    end

    class_methods do
      def acts_as_taskable
        include Todoro::Taskable
      end
    end

    def create_task_list(name)
      task_lists.create(name: name)
    end

    def add_task_to_list(task_list, title, description, expiry_date = nil)
      task_list.tasks.create(title: title, description: description, expiry_date: expiry_date, status: "pending")
    end

    private

    def ensure_taskable_registered
      # Placeholder for additional logic if needed in future (like logging)
    end
  end
end

ActiveSupport.on_load(:active_record) do
  extend Todoro::Taskable::ClassMethods
end

