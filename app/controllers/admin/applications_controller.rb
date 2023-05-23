class Admin::ApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets
    @ap_id = ApplicationPet.all.first.id
    @application_pet = ApplicationPet.find(@ap_id)
  end

  def update
    # require 'pry'; binding.pry
    ap = ApplicationPet.find(params[:ap_id])
    application = Application.find(params[:id])
    ap.update(ap_status: "Approved")
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
