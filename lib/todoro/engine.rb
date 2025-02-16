module Todoro
  class Engine < ::Rails::Engine
    isolate_namespace Todoro

    initializer "todoro.taskable" do
      ActiveSupport.on_load(:active_record) do
        extend Todoro::Taskable::ClassMethods
      end
    end

    initializer "todoro.assets.precompile" do |app|
      app.config.assets.precompile += %w[todoro/application.css todoro/application.js]
    end
  end
end
