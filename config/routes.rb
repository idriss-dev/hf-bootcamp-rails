Rails.application.routes.draw do
  resources :objectives
  resources :accounts do
    collection do
      post 'invite'
    end
  end

  post 'signin' => 'account_token#create'

  # TO DO Organizations, Departments
end
