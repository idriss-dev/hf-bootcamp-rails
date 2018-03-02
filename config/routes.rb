Rails.application.routes.draw do
  resources :organizations
  resources :departments
  resources :objectives
  resources :accounts do
    collection do
      post 'invite'
      post 'signup'
      post 'signin' => 'account_token#create'
    end
  end

  # TODO Organizations, Departments
end
