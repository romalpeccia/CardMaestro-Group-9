Rails.application.routes.draw do
  
  
 
  #get 'trades/new'
  post '/paypal-transaction-complete', to: 'trades#payment_from_user'
  get '/search' =>'searchpage#search', as: 'searchpage_search'
  get '/home' =>'home#index', as: 'home'

  get 'states/:country', to: 'searchpage#states'
  get 'cities/:state/:country', to: 'searchpage#cities'

  get 'states/:country', to: 'users/registrations#states'
  get 'cities/:state/:country', to: 'users/registrations#cities'

  post '/conversations/:id', to: 'conversations#create_message'

  #devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    #get 'signup', to: 'devise/registrations#new'
    get 'signup', to: 'users/registrations#new'
  end

  # devise controller
  devise_for :users, controllers: { registrations: "users/registrations" }
  
  resources :conversations


  get 'welcome/index'
  get 'pages/info'

  get 'about/index'
  get 'terms/index'
  get 'sitemap/index'
  get 'faq/index'
  get 'contact/index'
  get 'privacy/index'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  
  resources :cards, :collections, :trades, :ratings
end
