class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters
    @pets = Pet.joins([:application, :shelter])
    require 'pry'; binding.pry
    # find pending application, for pending apps need to know what the pet ids are
    # And then what shelter.id that pet is connected too, and the shelte name

  end
end