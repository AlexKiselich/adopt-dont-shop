class Admin::ApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_applications = @application.application_pets
  end

  def update
    if params[:reject] != nil
      @ap_id = ApplicationPet.find(params[:reject]).id
      @ap = ApplicationPet.find(params[:reject])
      application = Application.find(params[:id])
      @ap.update(ap_status: "Rejected")
    elsif params[:approve] != nil
      @ap_id = ApplicationPet.find(params[:approve]).id
      @ap = ApplicationPet.find(params[:approve])
      application = Application.find(params[:id])
      @ap.update(ap_status: "Approved")
    end
    application.save 
    redirect_to "/admin/applications/#{application.id}"
  end

end

