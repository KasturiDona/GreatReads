class ReadingsController < ApplicationController

	# before_action :check_if_logged_in, :only => [:index, :show, :edit, :update, :destroy, :new, :create]
 #  	before_action :check_if_admin, :only => [:index, :show, :edit, :update, :destroy, :new, :create]

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

	# def check_if_logged_in
 #    	redirect_to root_path unless @current_user.present?
	# end

	# def check_if_admin
	#     redirect_to root_path unless @current_user.present? && @current_user.admin?
	# end
end
