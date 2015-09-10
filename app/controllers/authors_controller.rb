# all methods for the authors model is defined here

class AuthorsController < ApplicationController
	before_action :check_if_logged_in, :only => [:index, :show]
  	before_action :check_if_admin, :only => [:edit, :update, :destroy, :new, :create]

	def index
		@authors = Author.order(:name)
	end

	def show
		@author = Author.find params[:id]
	end

	def new
		@author = Author.new
	end

	def create
		author = Author.create author_params
		redirect_to author
	end

	def destroy
		author = Author.find params[:id]
		author.destroy
		redirect_to authors_path
	end

	def edit
		@author = Author.find params[:id]
	end

	def update
		author = Author.find params[:id]
		author.update author_params
		redirect_to author
	end

	private
	def author_params
		params.require(:author).permit(:name, :pen_name, :dob, :dod, :nationality, :image)
	end

	def check_if_logged_in
    	redirect_to root_path unless @current_user.present?
	end

	def check_if_admin
	    redirect_to root_path unless @current_user.present? && @current_user.admin?
	end
end
