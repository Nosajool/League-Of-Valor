FactoryGirl.define do
	factory :user do
		name                  "test"
		email                 "test@example.com"
		password              "foobar"
		password_confirmation "foobar"
	end
end