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
    25.times do

      users.each { |user| user.champions.create!(table_champion_id: 1 + rand(119),
                                                 experience: 1 + rand(200),
                                                 position: 1 + rand(5),
                                                 level: 1 + rand(200),
                                                 skin: 1000000000,
                                                 active_skin: rand(9) ) }
    end
  end
end