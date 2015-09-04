Rails.application.routes.draw do
  get '/users/edit' => 'users#edit', :as => :edit_user
  resources :users, :except => [:edit]

  get '/loogin' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  
end
