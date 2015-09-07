class BooksController < ApplicationController

	before_action :check_if_logged_in, :only => [:index, :show]
  	before_action :check_if_admin, :only => [:edit, :update, :destroy, :new, :create]

	def index
		@books = Book.all
	end

	def show
		@book = Book.find params[:id]
	end

	def new
		@book = Book.new
	end

	def create
		book = Book.create book_params
		redirect_to book
	end

	def edit
		@book = Book.find params[:id]
	end

	def update
		book = Book.find params[:id]
		book.update book_params
		redirect_to book
	end

	def destroy
		book = Book.find params[:id]
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :publisher, :year, :image, :isbn, :author_id)
	end

	def check_if_logged_in
    	redirect_to root_path unless @current_user.present?
  	end

  	def check_if_admin
    	redirect_to root_path unless @current_user.present? && @current_user.admin?
  	end

end
