class BuffsController < ApplicationController
  def show
  	@buff = Buff.find(params[:id])
  end

  def index
  	@buffs = Buff.all
  end
end
