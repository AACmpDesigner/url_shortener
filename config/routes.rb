Rails.application.routes.draw do
  resources :url_shorts, only: [:index, :create, :new]
  get '/:short_url', to: 'url_shorts#to_original'
  root 'url_shorts#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
