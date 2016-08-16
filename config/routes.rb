Rails.application.routes.draw do
  resources :plans, only: [:create, :index, :show, :update] do
    resources :subscriptions, only: [:create, :destroy, :show, :index]
  end

  resources :users, only: [:create, :update, :destroy, :show] do
    resources :check_ins, only: [:create, :update, :destroy, :index]
    resources :logs, only: [:create, :update, :destroy, :index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
