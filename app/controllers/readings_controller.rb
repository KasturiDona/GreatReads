class ReadingsController < ApplicationController

	def index
		@readings = Reading.all
	end

	def show
		@reading = Reading.find params[:id]
	end

	def new
		@reading = Reading.new
	end

	def create
		reading = Reading.create reading_params
		redirect_to reading
	end

	def edit
		@reading = Reading.find params[:id]
	end

	def update
		reading = Reading.find params[:id]
		reading.update reading_params
		redirect_to reading
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
end
