Reposearch::Application.routes.draw do
  root to: "sessions#new"

  get '/github_authorization', to: "github#authorize"
  match '/search',               to: "github#search",   as: :github_search
  get '/home',                 to: "pages#home" 

  match '/login',     to: 'sessions#new',     as: :signin
  match '/authorize', to: 'sessions#create',  as: :authorize
  match '/logout',    to: 'sessions#destroy', as: :logout

  match "/*url", to: "base#routing_error"
end
