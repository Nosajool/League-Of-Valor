class TableChallengerController < ApplicationController

	def index
		@challengers = TableChallenger.all
	end

end
