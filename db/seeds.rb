# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

puts "Inputting Table Champion Data"
table_champion_data = 'app/data/champions.csv'
# Champion Table Data
CSV.foreach(table_champion_data) do |row|
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

# The empty table champion
TableChampion.create!({
    id: 999,
    champ_name: "No Champion",
    health: 1,
    attack_damage: 1,
    ability_power: 1,
    armor: 1,
    magic_resist: 1,
    role: "Marksman",
    catch_rate: 1,
    range: 1 
})
puts
puts "placeholder champion added"
puts

puts "Inputting Map Data"
# Map Data
File.open("app/data/maps.txt").each do |line|
    utfGood = line.encode( line.encoding, "binary", :invalid => :replace, :undef => :replace)
    stuff = utfGood.split("\t")
    Map.create!({
        map_name: stuff[0].chomp,
        description: stuff[1].chomp
    })
    puts "#{stuff[0]} added"
end

# Map Champion Data

puts
puts "Inputting Map Champion Data"

map_champion_data = 'app/data/map_champions.csv'
CSV.foreach(map_champion_data) do |row|
    a = Map.find(row[0])
    a.map_champions.create!( {
    champ_id: row[1],
    probability: row[2]
    })
  puts "#{row[1]} added with probability #{row[2]}"
end