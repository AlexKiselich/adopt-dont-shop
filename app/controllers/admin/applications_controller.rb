class Admin::ApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    application = Application.find(params[:id])
    application.update(status: "Approved")
    application.save 
    redirect_to "/admin/applications/#{application.id}"
  end
end
