FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email)     { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
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

# Turn this into some sort of task that loads all of the champions
# for the test database
  factory :table_champion, class: TableChampion do
    champ_name "Renekton"
    health 100
    attack_damage 23
    ability_power 34
    armor 78
    magic_resist 94
    role "Marksman"
    catch_rate 6300
    range 3
  end
end