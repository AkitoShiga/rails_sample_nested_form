Rails.application.routes.draw do
  root to: 'parents#index'
  resources :parents, only: %i(new create index show destroy)
end
