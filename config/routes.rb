Rails.application.routes.draw do
  resources :objectives
  resources :accounts

  post 'signin' => 'account_token#create'

  # TO DO Organizations, Departments
end
