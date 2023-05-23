class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters
    @pending_shelters = Shelter.pending_apps
  end
end