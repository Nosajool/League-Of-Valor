FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email)     { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :champion do
  	table_champion_id 8
  	experience 125
  	level 5
  	position 3
  	skin 1000000000
  	active_skin 2
  	user
  end
end