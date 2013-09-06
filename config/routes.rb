Bunsho::Application.routes.draw do
  root :to => 'home#index'

  get "home/index"

  get 'documents/:uuid', :to => 'documents#show', :as => 'document_show'
  get 'documents/file/:uuid', :to => 'documents#file', :as => 'document_file'

  namespace :rest do
    post 'documents', :to => 'documents#create', :as => 'documents_create'
    get 'documents/:uuid', :to => 'documents#show', :as => 'document_show'
    get 'documents/url', :to => 'documents#url', :as => 'document_url'
  end

  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end
