class Admin::ApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_applications = @application.application_pets
    @app_id = ApplicationPet.find_by(application_id: @application.id, pet_id:
    require 'pry'; binding.pry
    # find by both FK
    #     if ApplicationPet.all.first.application_id = @application.id
    # require 'pry'; binding.pry
    # @ap_id = ApplicationPet.all.first
    # @application_pet = ApplicationPet.find(@ap_id)
  end



  def update
    require 'pry'; binding.pry
    @ap_id = ApplicationPet.all.first.id
    @ap = ApplicationPet.find(@ap_id)
    application = Application.find(@ap.application_id)
  # require 'pry'; binding.pry
    if params[:reject] != nil
      @ap.update(ap_status: "Rejected")
    elsif params[:approve] != nil
      @ap.update(ap_status: "Approved")
    end
    application.save 
    redirect_to "/admin/applications/#{application.id}"
  end

  def reject 
    application = Application.find(params[:id])
    application.update(status: "Rejected")
    application.save 
    redirect_to "/admin/applications/#{application.id}"
  end
end
