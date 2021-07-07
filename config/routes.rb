Rails.application.routes.draw do

  root 'pages#index'
  resources :pages, only: %i[index create]
end
