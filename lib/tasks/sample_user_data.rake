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
      puts "#{username} added to user table"
    end

    users = User.all(limit: 6)
    # Set roster champions
    for x in 1..6 do
      users.each do |user|
        rand_id = TableChampion.order("RANDOM()").first.id
        while rand_id == 999 do
          rand_id = TableChampion.order("RANDOM()").first.id
        end
        user.champions.create!(table_champion_id: rand_id,
                               experience: 1 + rand(200),
                               position: x,
                               level: 1,
                               skin: 1000000000,
                               active_skin: 0)
        puts "#{user.username} roster champ #{x} = #{rand_id}"
      end
    end
    # Create the rest of the champions
    25.times do

      users.each do |user|
        rand_id = TableChampion.order("RANDOM()").first.id
        while rand_id == 999 do
          rand_id = TableChampion.order("RANDOM()").first.id
        end
        user.champions.create!(table_champion_id: rand_id,
                               experience: 1 + rand(200),
                               position: 0,
                               level: 1 + rand(200),
                               skin: 1000000000,
                               active_skin: rand(2) )
        puts "#{user.username} bench champ = #{rand_id}"
      end
    end
  end
end