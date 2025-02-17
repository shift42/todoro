require "rails/generators"
require "rails/generators/active_record"

module Todoro
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("templates", __dir__)

      def create_migrations
        migration_template "create_todoro_task_lists.rb", "db/migrate/create_todoro_task_lists.rb"
        migration_template "create_todoro_tasks.rb", "db/migrate/create_todoro_tasks.rb"
        migration_template "create_todoro_reminders.rb", "db/migrate/create_todoro_reminders.rb"
        migration_template "add_indexes_to_todoro_tasks.rb", "db/migrate/add_indexes_to_todoro_tasks.rb"
        migration_template "update_todoro_tasks_for_enhanced_features.rb", "db/migrate/update_todoro_tasks_for_enhanced_features.rb"
        migration_template "create_todoro_task_steps.rb", "db/migrate/create_todoro_task_steps.rb"
        migration_template "create_todoro_task_assignments.rb", "db/migrate/create_todoro_task_assignments.rb"
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end
    end
  end
end
