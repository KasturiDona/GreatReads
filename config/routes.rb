Rails.application.routes.draw do
	
  get '/users/edit' => 'users#edit', :as => :edit_user
  resources :authors, :books, :readings, :reviews, :genres, :users, :except => [:edit]

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  
end
