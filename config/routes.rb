Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :plans, only: [:create, :index, :show, :update] do
    member do
      get 'weight_chart'
      get 'bmi_chart'
    end
    resources :subscriptions, only: [:create, :destroy, :show, :index] do
      member do
        get 'weight_chart'
        get 'bmi_chart'
      end
    end
  end

  resources :users, only: [:create, :update, :destroy, :show] do
    member do
      get 'weight_chart'
      get 'bmi_chart'
    end
    resources :check_ins, only: [:create, :update, :destroy, :index]
    resources :logs, only: [:create, :update, :destroy, :index]
  end

  post 'login' => 'user_session#create', as: :login
  delete 'logout' => 'user_session#destroy'
  get 'welcome' => 'welcome#show'

  root 'welcome#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
