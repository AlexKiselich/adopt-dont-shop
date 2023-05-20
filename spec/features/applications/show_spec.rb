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
    it "shows a section on the page to 'Add a pet to this Application', and then I can add a pet's name and be redirected to the show page with that pet's name " do
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/applications/#{ben.id}"
      expect(page).to have_content("Status: In Progress")
      expect(page).to have_content("Add a Pet to this Application")

      fill_in("search", with: "Scooby")
      click_on "Search"
      expect(current_path).to eq("/applications/#{ben.id}")
      expect(page).to have_content(pet.name)
    end

    # 5. Add a Pet to an Application
    it "shows me the pet names and has a button to adopt " do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/applications/#{ben.id}"
save_and_open_page
      fill_in("search", with: "Scooby")
      click_on "Search"
save_and_open_page
      expect(page).to have_button("Adopt this Pet")
      click_button "Adopt this Pet"
      expect(current_path).to eq("/applications/#{ben.id}")
      expect(page).to have_content("Pets on this Application: Scooby")
    save_and_open_page
    end
  end
end