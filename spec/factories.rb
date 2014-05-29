FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email)     { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

end