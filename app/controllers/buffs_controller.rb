class BuffsController < ApplicationController
  def show
  end

  def index
  	@buffs = Buff.all
  end
end
