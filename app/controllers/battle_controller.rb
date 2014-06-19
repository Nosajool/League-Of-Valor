class BattleController < ApplicationController
  def battle
  end

  def setup
  	if params[:opp_id]
  		@opponent = User.find(params[:opp_id])
		@opp_roster = @opponent.champions.where("position != '0'")
		@roster = current_user.champions.where("position != '0'")
  	end
  end
end
