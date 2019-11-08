Rails.application.routes.draw do
  
  
  get '/search' =>'searchpage#search', as: 'searchpage_search'


  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end
  
  get 'welcome/index'
  get 'pages/info'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  
  resources :cards
end
