require 'lol'
class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		redirect_to current_user
  	end
  end

  def help
    client = Lol::Client.new APP_CONFIG['riot_api_key'], {region: "na"}
    @loreData = client.league.get(23032897)["23032897"][0].entries[0].player_or_team_name
  end

  def about  	
  end

  def contact  	
  end
end
 