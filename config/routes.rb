Rails.application.routes.draw do
  resources :organizations

  resources :departments do
    resources :objectives do
      member do
        get 'tree'
      end
    end
  end

  resources :accounts do
    collection do
      post 'invite'
      post 'signup'
      post 'signin' => 'account_token#create'
    end
  end
end
