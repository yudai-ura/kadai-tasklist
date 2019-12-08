Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, only:[:new, :show, :create, :edit, :update, :destroy]
  
  get 'signup', to: 'users#new'
  resources :users, only:[:create]
  
end
