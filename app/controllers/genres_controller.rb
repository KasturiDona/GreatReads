class GenresController < ApplicationController

	before_action :check_if_logged_in, :only => [:index]
  	before_action :check_if_admin, :only => [:show, :edit, :update, :destroy, :new, :create]
	
	def index
		@genres = Genre.all
	end

	def show
		@genre = Genre.find params[:id]
	end

	def new
		@genre = Genre.new
	end

	def create
		genre = Genre.create genre_params
		redirect_to genre
	end

	def destroy
		genre = Genre.find params[:id]
		genre.destroy
		redirect_to genres_path
	end

	def edit
		@genre = Genre.find params[:id]
	end

	def update
		genre = Genre.find params[:id]
		genre.update genre_params
		redirect_to genre
	end

	private
	def genre_params
		params.require(:genre).permit(:name)
	end

	def check_if_logged_in
    	redirect_to root_path unless @current_user.present?
	end

	def check_if_admin
	    redirect_to root_path unless @current_user.present? && @current_user.admin?
	end

end
