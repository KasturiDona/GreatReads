Rails.application.routes.draw do
	root :to => 'pages#home'
	# get '/home' => 'pages#home'
	# get '/users/edit' => 'users#edit', :as => :edit_user
	# get '/authors/edit' => 'authors#edit', :as => :edit_author
	# get '/books/edit' => 'books#edit', :as => :edit_book
	# get '/genres/edit' => 'genres#edit', :as => :edit_genre
	# get '/readings/edit' => 'readings#edit', :as => :edit_reading
	# get '/reviews/edit' => 'reviews#edit', :as => :edit_review

	resources :books do
		resources :reviews, :readings
	end

	# Clobber reviews, readings
	resources :authors, :genres, :users #, :except => [:edit]
	resources :readings, :reviews, :only => [:index]

	get '/login' => 'session#new'
	post '/login' => 'session#create'
	delete '/login' => 'session#destroy'
  
end
