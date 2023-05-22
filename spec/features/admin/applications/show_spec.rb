require "rails_helper"

RSpec.describe "/admin/applications show page" do 
  describe "when I visit an admin application show page" do 
  # 12. Approving a Pet for Adoption
    xit "has a button to approve a pet" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scooby = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true)
      mr_pirate = Pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      clawdia = Pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      lucille = Pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
      sarah = Application.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool")
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/admin/applications/#{sarah.id}"
      expect(page).to have_button("Approve")
      click_button "Approve"

      visit "/admin/applications/#{sarah.id}"
      expect(page).to have_content("Application Approved")
# test for an equal number of pets and Approve buttons?
# test for Application Approved message beside the pet?
    end

  # 13. Rejecting a Pet for Adoption
    xit "has a button to reject a pet" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scooby = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true)
      mr_pirate = Pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      clawdia = Pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      lucille = Pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
      sarah = Application.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool")
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/admin/applications/#{ben.id}"
      expect(page).to have_button("Reject")
      click_button "Reject"

      visit "/admin/applications/#{ben.id}"
      expect(page).to have_content("Application Rejected")
      expect(page).to_not have_button("Reject")
# test for an equal number of pets and Reject buttons?
# test for Application Rejected message beside the pet?
    end

  # 14. Approved/Rejected Pets on one Application do not affect other Applications
    xit "approved/rejects pets on one application do not affect other applications" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scooby = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true)
      mr_pirate = Pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      clawdia = Pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
      lucille = Pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
      sarah = Application.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool")
      ben = Application.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")
# pet show page?? How can we see/test for one pet having two applications linked to them? 

      visit "/admin/applications/#{ben.id}"
      expect(page).to have_button("Reject")
      click_button "Reject"

      visit "/admin/applications/#{sarah.id}"
      expect(page).to_not have_content("Application Accepted")
      expect(page).to_not have_content("Application Rejected")
      expect(page).to have_button("Accept")
      expect(page).to have_button("Reject")
    end
  end
end