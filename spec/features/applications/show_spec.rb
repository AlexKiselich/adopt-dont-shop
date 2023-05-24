require "rails_helper"

RSpec.describe "applications/show" do 
  describe "when I visit an applications show page" do 
  # 1. Application Show Page
    it "shows name, address, description, pet names, and application status " do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      @pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application = @pet.applications.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool", status: "In Progress")
      
      visit "/applications/#{application.id}"

      expect(page).to have_content("Sarah")
      expect(page).to have_content("123 Sesame Street, Denver, CO 80212")
      expect(page).to have_content("I am cool")
      expect(page).to have_content("Scooby")
      expect(page).to have_link("Scooby", href: "/pets/#{@pet.id}")
      expect(page).to have_content("In Progress")
    end

  # 4. Searching for Pets for an Application
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
      fill_in("search", with: "Scooby")
      click_on "Search"

      expect(page).to have_button("Adopt this Pet")

      click_button "Adopt this Pet"

      expect(current_path).to eq("/applications/#{ben.id}")
      expect(page).to have_content("Pets on this Application: Scooby")
    end

  # 6. Submit an Application
    it "allows me to submit an application and changes the status to pending" do
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Poodle", adoptable: true, shelter_id: shelter.id)
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/applications/#{ben.id}"
      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt this Pet"
      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt this Pet"

      expect(page).to have_content("Why I would make a good owner for these pet(s)")
      
      fill_in("good_owner", with: "I love cats!")
      click_button "Submit Application"

      expect(current_path).to eq("/applications/#{ben.id}")
      expect(page).to have_content("Status: Pending")
      expect(page).to have_content("Pets on this Application: Scooby")
      expect(page).to have_content("Pets on this Application: Scrappy")
      expect(page).to_not have_content("Add a Pet to this Application")
    end

  # 7. No Pets on an Application
    it "will not allow me to submit an application if there are no pets on the application" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")
      
      visit "/applications/#{ben.id}"

      expect(page).to_not have_content("Pets on this Application")
      expect(page).to_not have_content("Submit Application")
      expect(page).to_not have_content("Why I would make a good owner for these pet(s)")
    end
    
  # 8. Partial Matches for Pet Names
    it "returns partial matches to a pet search" do
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Poodle", adoptable: true, shelter_id: shelter.id)
      pet3 = Pet.create!(name: "Scoobster", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: shelter.id)
      pet4 = Pet.create!(name: "Scoob-a-loob-a-ding-dong", age: 4, breed: "Labrador Retriever", adoptable: true, shelter_id: shelter.id)
      pet5 = Pet.create!(name: "Here We Go Scooby-loo", age: 5, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/applications/#{ben.id}"
      fill_in("search", with: "Scoob")
      click_on "Search"

      expect(page).to have_content(pet.name)
      expect(page).to have_content(pet3.name)
      expect(page).to have_content(pet4.name)
      expect(page).to have_content(pet5.name)
      expect(page).to_not have_content(pet2.name)
    end
      
  # 9. Case Insensitive Matches for Pet Names
    it "returns case insensitive matches to a pet search" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Poodle", adoptable: true, shelter_id: shelter.id)
      pet3 = Pet.create!(name: "SCOOBY SNACKS", age: 3, breed: "Golden Retriever", adoptable: true, shelter_id: shelter.id)
      pet4 = Pet.create!(name: "scooby-a-looby-a-ding-dong", age: 4, breed: "Labrador Retriever", adoptable: true, shelter_id: shelter.id)
      pet5 = Pet.create!(name: "hErE wE gO sCoObY-LoO", age: 5, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/applications/#{ben.id}"
      fill_in("search", with: "Scooby")
      click_on "Search"

      expect(page).to have_content(pet.name)
      expect(page).to have_content(pet3.name)
      expect(page).to have_content(pet4.name)
      expect(page).to have_content(pet5.name)
      expect(page).to_not have_content(pet2.name)
    end
  end
end
