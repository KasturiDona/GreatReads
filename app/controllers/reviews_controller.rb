class ReviewsController < ApplicationController

	before_action :check_if_logged_in, :only => [:index, :show, :edit, :update, :destroy, :new, :create]
 #  	before_action :check_if_admin, :only => [:index, :show, :edit, :update, :destroy, :new, :create]

	def index
		@reviews = Review.all
	end

	def show
		@review = Review.find params[:id]
	end

	def new
		@review = Review.new
		@book = Book.find params[:book_id]
		@url = book_reviews_path(@book)
	end

	def create
		review_parameters = review_params
		review = @current_user.reviews.create review_parameters
		
		book = Book.find params[:book_id]
		book.reviews << review
		redirect_to book
	end

	def edit
		@review = Review.find params[:id]
		@url = book_review_path(@review.book.id, @review.id)
	end

	def update
		review = Review.find params[:id]
		review.update review_params
		redirect_to reviews_path
	end

	def destroy
		review = Review.find params[:id]
		review.destroy
		redirect_to reviews_path
	end

	private
	def review_params
		params.require(:review).permit(:description, :rating, :book_id, :user_id)
	end

	def check_if_logged_in
		redirect_to root_path unless @current_user.present?
	end

	# def check_if_admin
	# 	redirect_to root_path unless @current_user.present? && @current_user.admin?
	# end
end
