module ChampionsHelper
	def non_roster_hash(champs)
		champs_hash = Hash.new
		champs.each do |champ|
			champs_hash["#{champ.table_champion.champ_name} Level: #{champ.level} ID: #{champ.id} Position: #{champ.position}"] = champ.id
		end
		champs_hash
	end
end
