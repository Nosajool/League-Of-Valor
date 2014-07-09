module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		# Creates a cookie that expires 20.years.from_now
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	# Method called current_user=(user)
	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.digest(cookies[:remember_token])
		@current_user ||= User.includes(:champions).find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in_user
		unless signed_in?
			store_location
			flash[:danger] = "Please sign in."
			redirect_to signin_url
		end
	end

	def admin_user
		unless Rails.env.development?
			flash[:danger] = "An error has occured"
			redirect_to current_user
		end
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end
end
