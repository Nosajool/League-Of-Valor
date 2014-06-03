FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email)     { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    icon 1
  end

  factory :champion, class: Champion do
  	table_champion_id 1
  	experience 125
    user
  	position 3
  	skin 1000000000
  	active_skin 2
    level 5
  end


end