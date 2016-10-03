Rails.application.routes.draw do
  # devise_for :users 
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  
  
  get ":controller(/:action(/:id))"
  post ":controller(/:action(/:id))"
  root "home#index"

  
end
