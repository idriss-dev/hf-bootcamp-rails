Rails.application.routes.draw do
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
