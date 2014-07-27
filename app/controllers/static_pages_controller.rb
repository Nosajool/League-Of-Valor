require 'lol'
class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		redirect_to current_user
  	end
  end

  def help
    client = get_client
    @challengers = client.league.get(2648)["2648"][0].entries
    @stats = client.stats.ranked(2648).champions
  end

  def about  	
  end

  def contact  	
  end

  private
    def get_client
      Lol::Client.new APP_CONFIG['riot_api_key'], {region: "na"}
    end
end
 