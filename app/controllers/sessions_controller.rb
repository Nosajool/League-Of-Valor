class SessionsController < ApplicationController
	def new
		
	end

	def create
		user = User.find_by(username: params[:session][:username].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or(user)
		else
			flash.now[:danger] = 'Invalid username/password combination'
			render 'new'
		end
	end

	def destroy
		# To end the session, we want to sign out and return to the home page
		sign_out
		redirect_to root_url	
	end
end
