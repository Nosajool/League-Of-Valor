class RolesController < ApplicationController
	before_action :signed_in_user
	def index
		@roles = Role.where.not(name: "None")
	end

	def show
		@role = Role.find(params[:id])
		@primary = TableChampion.where(f_role: @role.name)
		@secondary = TableChampion.where(s_role: @role.name)
	end
end
