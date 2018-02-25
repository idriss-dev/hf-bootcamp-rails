Rails.application.routes.draw do
  resources :objectives
  resources :admins
  resources :users
  post 'account_token' => 'account_token#create'
  #  'user_token' => 'user_token#create'

  # TO DO list of ressources of the project Objectives, Organizations, Departments
end
