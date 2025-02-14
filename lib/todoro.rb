require "todoro/version"
require "todoro/engine"
require "todoro/taskable"

module Todoro
  class Engine < ::Rails::Engine
    isolate_namespace Todoro

    initializer "todoro.taskable" do
      ActiveSupport.on_load(:active_record) do
        extend Todoro::Taskable::ClassMethods
      end
    end
  end
end
