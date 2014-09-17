class TableChallengerController < ApplicationController
	before_action :signed_in_user
	def index
		@challengers = TableChallenger.all
	end

end
