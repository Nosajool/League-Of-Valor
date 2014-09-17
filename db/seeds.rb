require 'csv'
require 'json'
require 'lol'

def fix_riot_typos(role)
    if role == "Suppport"
        role = "Support"
    elsif role == "Figher"
        role = "Fighter"
    end
    return role
end

puts "Inputting Table Champion Data and Skin Data"
champion_stats_data = 'app/data/champion_stats.json'
file = File.read(champion_stats_data)
champions = JSON.parse(file)["data"]
champions.each do |key,val|
    temp = val["tags"][1]
    val["tags"][1] = fix_riot_typos(temp)
    x = TableChampion.create!({
        name: val["name"],
        hp: val["stats"]["hp"],
        attack_damage: val["stats"]["attackdamage"],
        armor: val["stats"]["armor"],
        magic_resist: val["stats"]["spellblock"],
        attack_range: val["stats"]["attackrange"],
        riot_id: val["id"],
        key: val["key"],
        title: val["title"],
        f_role: val["tags"][0],
        s_role: val["tags"][1],
        lore: val["lore"],
        hp_per_level: val["stats"]["hpperlevel"],
        attack_damage_per_level: val["stats"]["attackdamageperlevel"],
        armor_per_level: val["stats"]["armorperlevel"],
        magic_resist_per_level: val["stats"]["spellblockperlevel"],
        movespeed: val["stats"]["movespeed"]
    } )
    puts "#{val["name"]} added to the Champion table"
    val["skins"].each do |a|
        x.skins.create!({
            table_champion_id: x.id,
            num: a["num"],
            name: a["name"]
        } )
        puts "#{a["name"]} added to the list of Skins"
    end
end

# The empty table champion
TableChampion.create!({
    id: 999,
    name: "Empty",
    hp: 0,
    attack_damage: 0,
    armor: 0,
    magic_resist: 0,
    attack_range: 1,
    riot_id: 999,
    key: "Empty",
    title: "the Empty One",
    f_role: "None",
    s_role: "None",
    lore: "The empty champion was born somewhere in Valoran.",
    hp_per_level: 0,
    attack_damage_per_level: 0,
    armor_per_level: 0,
    magic_resist_per_level: 0,
    movespeed: 0
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
map_champion_data = 'app/data/map_champions.json'
file = File.read(map_champion_data)
champions = JSON.parse(file)
champions.each do |val|
    a = Map.find(val["mapid"])
    a.map_champions.create!({
        key: val["key"],
        probability: val["prob"]
    } )
    puts "#{val["key"]} added with probability #{val["prob"]}"
end

# Role Data
puts
puts "Input Role Data"
role_data = 'app/data/roles.json'
file = File.read(role_data)
roles = JSON.parse(file)
roles.each do |role|
    Role.create!({
        name: role["role"],
        hp_base: role["hp_base"],
        hp_per: role["hp_per"],
        ad_base: role["ad_base"],
        ad_per: role["ad_per"],
        ap_base: role["ap_base"],
        ap_per: role["ap_per"],
        ar_base: role["ar_base"],
        ar_per: role["ar_per"],
        mr_base: role["mr_base"],
        mr_per: role["mr_per"],
        ms_base: role["ms_base"],
        ms_per: role["ms_per"]
    })
    puts "#{role["role"]} added to the Role Table"
end


# Buff Data

puts
puts "Inputting Buff Data"
buff_data = 'app/data/buffs.json'
file = File.read(buff_data)
buffs = JSON.parse(file)
counter = 1
buffs.each do |buff|
    Buff.create!({
        name: buff["name"],
        title: buff["title"],
        description: buff["description"],
        user_id: counter,
        hp_base: buff["hp_base"],
        hp_per: buff["hp_per"],
        ad_base: buff["ad_base"],
        ad_per: buff["ad_per"],
        ap_base: buff["ap_base"],
        ap_per: buff["ap_per"],
        ar_base: buff["ar_base"],
        ar_per: buff["ar_per"],
        mr_base: buff["mr_base"],
        mr_per: buff["mr_per"],
        ms_base: buff["ms_base"],
        ms_per: buff["ms_per"]
    })
    puts "#{buff["title"]} added to the Buff Table"
    counter += 1
end

# Pro Data

puts
puts "Inputting Pro Data"
api_key = 0
if Rails.env.production?
    api_key = ENV['RIOT_API_KEY']
else
    api_key = APP_CONFIG['riot_api_key']
end
client = Lol::Client.new(api_key,{region: "na"})
challengers = client.league.get(2648)["2648"][0].entries
count = 0
challengers.sort_by! do |challenger|
    challenger.league_points
end
challengers.reverse!
challengers.each do |challenger|
  count +=1
  champions = client.stats.ranked(challenger.player_or_team_id).champions
  champions.sort_by! do |champion|
    champion.stats.total_sessions_played
  end
  champions.reverse!
  champ = TableChampion.where(riot_id: champions[1].id).first
  champ_id = champ.id
  TableChallenger.create!({
    name: challenger.player_or_team_name,
    table_champion_id: champ_id
  })
  puts "##{count}: #{challenger.player_or_team_name}'s #{champ.name} added to the pros table LP: #{challenger.league_points}"
  sleep 0.75
end
