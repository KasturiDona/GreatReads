class ReadingsController < ApplicationController

	before_action :check_if_logged_in, :only => [:index, :show, :edit, :update, :destroy, :new, :create]

	def index
		@readings = Reading.where( user_id: @current_user.id )
	end

	def show
		@reading = Reading.find params[:id]
	end

	# creating a new reading for a book
	def new
		@reading = Reading.new
		@book = Book.find params[:book_id]
		@url = book_readings_path(@book)
	end

	def create
		book = Book.find params[:book_id]
		reading = book.readings.find_or_create_by :user_id => @current_user.id
		reading.update :status => params[:reading][:status]
		
		redirect_to book
	end

	def edit
		@reading = Reading.find params[:id]
		@url = book_reading_path(@reading.book.id, @reading.id)
	end

	def update
		reading = Reading.find params[:id]
		reading.update reading_params
		redirect_to readings_path
	end

	def destroy
		reading = Reading.find params[:id]
		reading.destroy
		redirect_to readings_path
	end

	private
	def reading_params
		params.require(:reading).permit(:status, :book_id, :user_id)
	end

	def check_if_logged_in
    	redirect_to root_path unless @current_user.present?
	end

end
