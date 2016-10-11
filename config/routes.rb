Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users, :only => [:show, :index]
      post '/users/:id/edit/profic_update', to: 'users#profic_update', as: :profic_update
    end
  end

end