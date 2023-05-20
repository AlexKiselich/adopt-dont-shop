class ApplicationsController < ApplicationController
  def welcome
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    application = Application.new(app_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else 
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    application = Application.find(params[:id])
    if params[:good_owner] == nil
      pet = Pet.find(params[:pet_id])
      ApplicationPet.create(application_id: application.id, pet_id: pet.id)
      # application.pets << pet
    else
      application.update(status: "Pending")
      application.save 
    end
    redirect_to "/applications/#{application.id}"
  end

  private

  def app_params
    params.permit(:applicant, :address, :description, :status)
  end
  
end

