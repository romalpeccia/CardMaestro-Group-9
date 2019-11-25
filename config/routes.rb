Rails.application.routes.draw do
  
  
  #get 'trades/new'
  get '/search' =>'searchpage#search', as: 'searchpage_search'
  get '/home' =>'home#index', as: 'home'

  get 'states/:country', to: 'searchpage#states'
  get 'cities/:state/:country', to: 'searchpage#cities'

  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end
  
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

  
  resources :cards, :collections, :trades
end
