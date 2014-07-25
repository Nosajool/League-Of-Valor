require 'lol'
class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		redirect_to current_user
  	end
  end

  def help
    client = APP_CONFIG['riot_api_key'], {region: "na"}
    @loreData = client.static.champion.get(champData: 'lore')
  end

  def about  	
  end

  def contact  	
  end
end
