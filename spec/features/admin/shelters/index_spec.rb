require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @mr_pirate = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @lucille_bald = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

    @ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof", status: "In Progress")
    @sarah = Application.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool", status: "Pending")
    @simon = Application.create!(applicant: "Simon", address: "2345 Street Street, Denver, CO 80002", description: "I use gentle hands", status: "Pending")

    ApplicationPet.create!(pet: @mr_pirate, application: @sarah)
    ApplicationPet.create!(pet: @clawdia, application: @simon)
    ApplicationPet.create!(pet: @lucille_bald, application: @ben)



  end

  # 10. Admin Shelters Index
  it "lists all the shelter names in reverse alphabetical order" do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  #   For this story, you should fully leverage ActiveRecord methods in your query.

  # As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelters with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application
  it "displays a section for 'Shelters with Pending Applications', and shows the name of every shelter with pending applications" do
    
    visit "/admin/shelters"
    save_and_open_page
    within("pending_apps-#{@shelter.id}") do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)

    end


  #   within("#playlist-#{rock.id}") do
  #     expect(page).to have_content(rock.name)
  #     expect(page).to have_content(place.title)
  #     expect(page).to have_content(breadbox.title)
  #     expect(page).to have_content(r_and_c.title)
  end
end
