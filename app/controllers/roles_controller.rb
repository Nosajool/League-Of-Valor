class RolesController < ApplicationController
  def index
  	@roles = Role.all
  end
end
