class TableChampionsController < ApplicationController
  def index
  	@table_champions = TableChampion.all
  end
end
