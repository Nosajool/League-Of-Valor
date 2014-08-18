class BuffsController < ApplicationController
	before_action :signed_in_user
  def show
  	@buff = Buff.find(params[:id])
  end

  def index
  	@buffs = Buff.where.not(name: "None")
  end
end
