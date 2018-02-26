Rails.application.routes.draw do
  resources :objectives
  resources :admins
  resources :users

  post 'signin' => 'account_token#create'

  # TO DO Organizations, Departments
end
