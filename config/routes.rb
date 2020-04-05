Rails.application.routes.draw do
  get "/", to: redirect("/flights")

  namespace :api do
    namespace :v1 do
      resources :flights
    end
  end

  resources :flights

end
