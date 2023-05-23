class Admin::ApplicationsController < ApplicationController

  def show 
    # require 'pry'; binding.pry
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    # ApplicationPet.create(application_id: application.id, pet_id: pet.id)
    # @button = params[:button]
    application = Application.find(params[:id])
    # require 'pry'; binding.pry
    application.update(status: "Approved")
    application.save 
    redirect_to "/admin/applications/#{application.id}"
  end
end