Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      namespace :v1 do
        get '/users', to: 'users#index'
        get '/users/:login_name/(:year/:week)', to: 'users#show'
        get '/pull-requests', to: 'pull_requests#index'
        get '/pull-requests/:id', to: 'pull_requests#show'
        get '/scores', to: 'scores#index'
        get '/scores/:year/:week', to: 'scores#week'
      end
    end
  end
end
