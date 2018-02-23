Rails.application.routes.draw do
  post 'account_token' => 'account_token#create'
  resources :accounts
  'user_token' => 'user_token#create'
end
