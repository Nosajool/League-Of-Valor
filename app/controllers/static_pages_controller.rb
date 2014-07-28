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
    @api = Array.new
    @challengers.each do |challenger|
      new_record = APIRecord.new
      new_record.id = challenger.player_or_team_id
      new_record.name = challenger.player_or_team_name
      champions = client.stats.ranked(challenger.player_or_team_id).champions
      champions.sort_by! do |champion|
        champion.stats.total_sessions_played
      end
      champions.reverse!
      new_record.riot_id = champions[1].id
      new_record.champ_name = TableChampion.where(riot_id: champions[1].id).first.name
      new_record.games = champions[1].stats.total_sessions_played
      @api << new_record
      sleep 1
    end
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
 
class APIRecord
  attr_accessor :id
  attr_accessor :name
  attr_accessor :riot_id
  attr_accessor :champ_name
  attr_accessor :games
end