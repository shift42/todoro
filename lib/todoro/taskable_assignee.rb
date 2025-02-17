module Todoro
  module TaskableAssignee
    extend ActiveSupport::Concern

    included do
      has_many :task_assignments, as: :assignee, class_name: "Todoro::TaskAssignment", dependent: :destroy
      has_many :tasks, through: :task_assignments, source: :task
    end

    class_methods do
      def taskable_assignee
        Todoro.assignable_models << self.name unless Todoro.assignable_models.include?(self.name)

        Todoro::Task.class_eval <<-RUBY, __FILE__, __LINE__ + 1
            has_many :#{self.name.underscore.pluralize}, through: :task_assignments, source: :assignee, source_type: "#{self.name}"
        RUBY
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  extend Todoro::TaskableAssignee::ClassMethods
end
