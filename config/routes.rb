Rails.application.routes.draw do
  resources :objectives

  post 'signin' => 'account_token#create'

  # TO DO Organizations, Departments
end
