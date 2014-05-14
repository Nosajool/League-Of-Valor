class User < ActiveRecord::Base
	# Force all usernames and emails to be lowercase when entered into the database
	before_save { self.name = name.downcase }
	before_save { self.email = email.downcase }


	# Validate the username. Rails infers that :uniqueness is true when you use { case_sensitive: false }
	validates(:name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false } )

	# Validate the email address using regular expressions
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, presence: true,
			          format: { with: VALID_EMAIL_REGEX },
			          uniqueness: { case_sensitive: false } )
	# Validate the password
	has_secure_password
	validates :password, length: { minimum: 6 }
end
