namespace :db do
  desc "Fill Users with sample data"
  task populate: :environment do
    User.create!(username: "HotshotGG",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 icon: 1)
    25.times do |n|
      username  = Faker::Internet.user_name
      email = Faker::Internet.safe_email
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   icon: 1 + rand(30) )
    end

    users = User.all(limit: 6)
    # Set roster champions
    for x in 1..5 do
      users.each { |user| 
        user.champions.create!(table_champion_id: 1 + rand(119),
                               experience: 1 + rand(200),
                               position: x,
                               level: 1 + rand(200),
                               skin: 1000000000,
                               active_skin: 0) }
    end
    # Create the rest of the champions
    25.times do

      users.each { |user| user.champions.create!(table_champion_id: 1 + rand(119),
                                                 experience: 1 + rand(200),
                                                 position: 0,
                                                 level: 1 + rand(200),
                                                 skin: 1000000000,
                                                 active_skin: rand(9) ) }
    end
  end
end