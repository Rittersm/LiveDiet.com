Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :plans, only: [:create, :index, :show, :update] do
    resources :subscriptions, only: [:create, :destroy, :show, :index]
  end

  resources :users, only: [:create, :update, :destroy, :show] do
    resources :check_ins, only: [:create, :update, :destroy, :index]
    resources :logs, only: [:create, :update, :destroy, :index]
  end

  post 'login' => 'user_session#create'
  delete 'logout' => 'user_session#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
