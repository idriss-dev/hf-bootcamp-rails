Rails.application.routes.draw do
  resources :objectives
  resources :admins
  resources :users

  post 'signin' => 'account_token#create'

  # TO DO list of ressources of the project Objectives, Organizations, Departments
end
