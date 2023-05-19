require "rails_helper"

RSpec.describe "applications/show" do 
  # 1. Application Show Page
  describe "when I visit an applications show page" do 
    it "shows name, address, description, pet names, and application status " do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application = pet.applications.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool", status: "In Progress")

      visit "/applications/#{application.id}"

      expect(page).to have_content("Sarah")
      expect(page).to have_content("123 Sesame Street, Denver, CO 80212")
      expect(page).to have_content("I am cool")
      expect(page).to have_content("Scooby")
      expect(page).to have_content("In Progress")
    end
  end
end