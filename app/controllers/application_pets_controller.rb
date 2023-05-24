# class ApplicationPetsController < ApplicationController
#   def create
#     binding.pry
#     application = Application.find(params[:id])
#     if params[:good_owner] == nil
#       pet = Pet.find(params[:pet_id])
#       ApplicationPet.create(application_id: application.id, pet_id: pet.id)
#       # application.pets << pet
#     else
#       application.update(status: "Pending")
#       application.save 
#     end
#     redirect_to "/applications/#{application.id}"
#   end
# end