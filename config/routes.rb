Todoro::Engine.routes.draw do
  Todoro.taskable_models.each do |model|
    resource_name = model.underscore.pluralize.to_sym

    resources resource_name, defaults: { taskable_type: model.downcase }, only: [], constraints: TaskableModelsConstraint.new do
      resources :task_lists do
        resources :tasks, only: [ :new, :edit, :create, :update, :destroy ] do
          patch :complete, on: :member

          resources :task_steps, only: [ :create, :destroy ], path: "step" do
            patch :complete, on: :member
          end
        end
      end
    end
  end
end
