module ChallengersHelper
	def challenger_list_hash
		challenger_hash = Hash.new
		TableChallenger.all.each do |challenger|
			challenger_hash["##{challenger.id} #{challenger.name} | #{challenger.table_champion.name}"] = challenger.id
		end
		challenger_hash
	end
end
