class Admin::ApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_applications = @application.application_pets
    # @app_id = ApplicationPet.find_by(application_id: @application.id, pet_id:
    # find by both FK
    #     if ApplicationPet.all.first.application_id = @application.id
    # require 'pry'; binding.pry
    # @ap_id = ApplicationPet.all.first
    # @application_pet = ApplicationPet.find(@ap_id)
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

  # def reject 
  #   application = Application.find(params[:id])
  #   application.update(status: "Rejected")
  #   application.save 
  #   redirect_to "/admin/applications/#{application.id}"
  # end
end


  # <% @pets.each do |pet|%>
  #   <div id="app_status-<%= pet.id %>">
  #   <p>Pets on this Application: <%= link_to pet.name, "/pets/#{pet.id}" %> 
  #   <% if @pet_applications.ap_status == ("Pending") %> 
  #     <p><%= button_to "Approve", action: "update", :accept => @pet_applications.id %></p>
  #     <p><%= button_to "Reject", action: "update", :reject => @pet_applications.id %></p>
  #   <% elsif @pet_applications.ap_status == ("Rejected") %>
  #     <p>Pet Application Status: Rejected</p>
  #   <% else %>
  #     <p>Pet Application Status: Approved</p>
  #   </div>
  #   <% end %>
  # <% end %>
  # <p>Application Status: <%= @application.status %></p