require 'csv'

namespace :db do

  desc "Import CSV Data"
  task :champions => :environment do

    csv_file_path = 'app/data/champions.csv'

    CSV.foreach(csv_file_path) do |row|
      TableChampion.create!( {
        champ_name: row[0],
        health: row[1],
        attack_damage: row[2],
        ability_power: row[3],
        armor: row[4],
        magic_resist: row[5],
        role: row[6],
        catch_rate: row[7],
        range: row[8] } )
      puts "#{row[0]} added"
    end
  end
end