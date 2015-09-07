class ReviewsController < ApplicationController

	# before_action :check_if_logged_in, :only => [:index, :show, :edit, :update, :destroy, :new, :create]
 #  	before_action :check_if_admin, :only => [:index, :show, :edit, :update, :destroy, :new, :create]

	def index
		@reviews = Review.all
	end

	def show
		@review = Review.find params[:id]
	end

	def new
		@review = Review.new
	end

	def create
		review = Review.create review_params
		redirect_to review
	end

	def edit
		@review = Review.find params[:id]
	end

	def update
		review = Review.find params[:id]
		review.update review_params
		redirect_to review
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

	# def check_if_logged_in
	# 	redirect_to root_path unless @current_user.present?
	# end

	# def check_if_admin
	# 	redirect_to root_path unless @current_user.present? && @current_user.admin?
	# end
end
