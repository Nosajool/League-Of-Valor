namespace :db do
  desc "Fill Users with sample data"
  task populate: :environment do
    User.create!(username: "HotshotGG",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    25.times do |n|
      username  = Faker::Internet.user_name
      email = Faker::Internet.safe_email
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do

      users.each { |user| user.champions.create!(table_champion_id: rand(20),
                                                 experience: rand(200),
                                                 position: rand(5),
                                                 level: rand(200),
                                                 skin: 1000000000,
                                                 active_skin: rand(9) ) }
    end
  end
end