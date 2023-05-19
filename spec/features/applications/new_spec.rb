require 'rails_helper'

RSpec.describe '#new' do
  describe 'When I visit the application new page' do
    it 'displays a form for a new adoption' do
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application = pet.applications.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool", status: "In Progress")

      visit "/applications/new"
      
      expect(page).to have_field("applicant")
      expect(page).to have_field("address")
      expect(page).to have_field("description")
    end

    context "given valid data" do
      it "allows me to fill out form and takes me back to the new application's show page" do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

        visit "/applications/new"

        fill_in("applicant", with: "Sarah")
        fill_in("address", with: "123 Sesame Street, Denver, CO 80212")
        fill_in("description", with: "I am cool")

        click_button "Submit"
        
        expect(page).to have_content("Show Application")
        expect(page).to have_content("Applicant Name: Sarah")
        expect(page).to have_content("Address: 123 Sesame Street, Denver, CO 80212")
        expect(page).to have_content("Why you? I am cool")
        expect(page).to have_content("Application Status: In Progress") 
      end
    end

    context "given invalid data" do
      it "when I fail to fill in any of the form fields it takes me back" do
        shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

        visit "/applications/new"
        fill_in("applicant", with: "Sarah")
        fill_in("address", with: "123 Sesame Street, Denver, CO 80212")
        fill_in("description", with: "")
        
        click_button "Submit"

        expect(page).to have_content("Error: Description can't be blank")
        expect(page).to have_current_path("/applications/new")
      end  
    end
  end
end