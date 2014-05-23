class User < ActiveRecord::Base
	# Force all emails to be lowercase when entered into the database
	before_save { self.username = username.downcase }
	before_save { self.email = email.downcase }
	before_create :create_remember_token


	# Validate the username. Rails infers that :uniqueness is true when you use { case_sensitive: false }
	validates(:username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false } )

	# Validate the email address using regular expressions
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, presence: true,
			          format: { with: VALID_EMAIL_REGEX },
			          uniqueness: { case_sensitive: false } )
	# Validate the password
	has_secure_password
	validates :password, length: { minimum: 6 }


	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
