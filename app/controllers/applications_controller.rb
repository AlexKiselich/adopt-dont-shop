class ApplicationsController < ApplicationController
  def welcome
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.create!(app_params)
    redirect_to "/applications/#{application.id}"
  end
  private

  def app_params
    params.permit(:applicant, :address, :description, :status)
  end
  
end

