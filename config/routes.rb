Todoro::Engine.routes.draw do
  resources :taskables, only: [] do
    resources :task_lists do
      resources :tasks do
        member do
          patch :complete
        end
      end
    end
  end
end
