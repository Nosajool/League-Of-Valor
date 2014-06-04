class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
		@champions = @user.champions
		# Give roster champions
		@roster = @champions.where.not("position = '0'")
	end
	def new
		@user = User.new		
	end
	def create
		@user = User.new(user_params)
		# Give a default icon to ppl that create new accounts
		@user.icon = 1
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Vion Genesis"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end


	private
		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end

		# Before Filters 

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)	
		end

		def store_location
			session[:return_to] = request.url if request.get?
		end
end
