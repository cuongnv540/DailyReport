SampleApp::Application.routes.draw do
  get "groups/new"

  get "catalogs/new"

  resources :users 
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :catalogs
  resources :groups 
  resources :reports do
    match 'search' => 'reports#search',  on: :collection, via: [:get, :post], as: :search
  end
  
  root to: 'static_pages#home'
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/active', to: 'users#active'
  match '/define', to: 'users#define'
  match '/manager_report', to: 'reports#manager_report'
  match '/report_member', to: 'reports#report_member'
  match '/report_all', to: 'reports#report_all'
  match '/report_results', to: 'reports#report_results'
  
end