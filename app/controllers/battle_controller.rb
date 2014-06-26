class BattleController < ApplicationController
  def battle
    opponent = User.find(params[:opp_id])

    roster = getRoster(current_user)
    roster_count = roster.count
    if(roster_count < 1 || roster_count > 5)
      flash[:error] = "Invalid User Roster"
      redirect_to champ_select_path(opponent.id)
    end


    opp_roster = getRoster(opponent)
    opp_roster_count = opp_roster.count
    if(opp_roster_count <1 || opp_roster_count >5)
      flash[:error] = "Sorry, your opponent does not have a valid roster"
      redirect_to champ_select_path(opponent.id)
    end

    user_hp = Array.new
    opp_hp = Array.new
    roster.each do |champ|
      user_hp << champ.table_champion.hp + (champ.table_champion.hp*005.0*champ.level).round
    end
    opp_roster.each do |champ|
      opp_hp << champ.table_champion.hp
    end
    # Pause, learning Riot Games API to retrieve champion data
    # Need to learn Json/Javascript before continueing
  end

  def setup
  	if params[:opp_id]
    	@opponent = User.find(params[:opp_id])
  		@opp_roster = getRoster(@opponent)
  		@roster = getRoster(current_user)
  	end
  end

  private
    def getRoster(user)
      roster = []
      # Fill @roster array with empty champions
      for x in 0..4
        if user.champions.where(position: (x+1)).exists?
          roster << user.champions.where(position: (x+1)).first
        end
      end
      roster
    end

end
