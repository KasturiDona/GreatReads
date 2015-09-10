class UsersController < ApplicationController
	before_action :check_if_logged_in, :only => [:index, :edit, :update]
	before_action :check_if_admin, :only => [:index]

	def index
		@users = User.all
	end

	def show
		@user = User.find params[:id]
		# binding.pry
	end

	def new
		@user = User.new
	end

	# while creating a new account a user can upload an image via cloudinary
	def create
		user_details = user_params
		@user = User.new user_details
		if params[:file]
			response = Cloudinary::Uploader.upload params[:file]
			user_details["image"] = response["url"]
		end

		# a user is directly logged in once he/she creates an account
		if @user.save
  			session[:user_id] = @user.id
  			redirect_to root_path
		else
			render :new
		end
	end

	def edit
		@user = @current_user
	end

	# editing user profile
	def update
		@user = @current_user
		user_details = user_params
		if params[:file]
			response = Cloudinary::Uploader.upload params[:file]
			user_details["image"] = response["url"]
		end
		if @user.update user_details
			redirect_to @user
		else
			render :edit
		end
	end

	def destroy
		user = User.find params[:id]
		user.destroy unless user.admin?
		redirect_to root_path
	end

	# white-listing of current user params
	private
	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end

	def check_if_logged_in
		redirect_to root_path unless @current_user.present?
	end

	def check_if_admin
		redirect_to root_path unless @current_user.present? && @current_user.admin?
	end
end
