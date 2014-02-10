Reposearch::Application.routes.draw do
  root to: "sessions#new"

  match '/authorize', to: 'sessions#create',  as: :authorize
  match '/login',     to: 'sessions#new',     as: :signin
  match '/logout',    to: 'sessions#destroy', as: :logout

  match '/github_authorization', to: "github#authorize",  as: :github_authorization
  match '/search',               to: "github#search",     as: :github_search
  match '/paginate',             to: "github#paginate",   as: :github_paginate

  match "/*url", to: "base#routing_error"
end
