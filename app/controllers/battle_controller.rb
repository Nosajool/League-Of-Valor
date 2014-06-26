class BattleController < ApplicationController
  def battle
    opponent = User.find(params[:opp_id])
    
    roster = getRoster(current_user)
    opp_roster = getRoster(opponent)

    valid_rosters(roster,opp_roster)

    team = setup_team(roster)
    opp_team = setup_team(opp_roster)

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

    def valid_rosters(roster, opp_roster)
      roster_count = roster.count
      opp_roster_count = opp_roster.count
      if(roster_count < 1 || roster_count > 5)
        flash[:error] = "Invalid User Roster"
        redirect_to champ_select_path(opponent.id)
      elsif(opp_roster_count < 1 || opp_roster_count > 5)
        flash[:error] = "Sorry, your opponent does not have a valid roster"
        redirect_to champ_select_path(opponent.id)
      end
    end

    def setup_team(roster)
      team = Array.new
      roster.each do |champ|
        team << BattleChampion.new(champ)
      end
      team
    end

end
