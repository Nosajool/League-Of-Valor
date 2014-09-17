namespace :db do
  desc "Fill Users with sample data"
  task more_users: :environment do
    25.times do |n|
      username  = Faker::Internet.user_name
      email = Faker::Internet.safe_email
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   icon: 1 + rand(30) )
      puts "#{username} added to user table"
    end
  end
end