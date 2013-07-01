Bunsho::Application.routes.draw do
  root :to => 'home#index'

  get "home/index"

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
