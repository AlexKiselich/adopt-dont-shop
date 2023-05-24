require "rails_helper"

RSpec.describe "admin applications show page" do 
  describe "when I visit an admin application show page" do 
  # 12. Approving a Pet for Adoption
    it "has a button to approve a pet" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      @mr_pirate = shelter.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
      @sarah = @mr_pirate.applications.create!(applicant: "Sarah", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool")

      visit "/admin/applications/#{@sarah.id}"

      expect(page).to have_content("Application Status: In Progress")
      expect(page).to have_button("Approve")

    
      click_on "Approve"
     
      
      visit "/admin/applications/#{@sarah.id}"
    
      expect(page).to have_content("Pet Application Status: Approved")
      expect(page).to_not have_button("Approve")
# test for an equal number of pets and Approve buttons?
    end

  # 13. Rejecting a Pet for Adoption
    it "has a button to reject a pet" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      clawdia = shelter.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)      
      ben = clawdia.applications.create!(applicant: "Ben", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")
      
      visit "/admin/applications/#{ben.id}"

      expect(page).to have_content("Application Status: In Progress")
      expect(page).to have_button("Reject")
      click_button "Reject"

      visit "/admin/applications/#{ben.id}"

      expect(page).to have_content("Pet Application Status: Rejected")
      expect(page).to_not have_button("Reject")
# test for an equal number of pets and Reject buttons?
    end

  # 14. Approved/Rejected Pets on one Application do not affect other Applications
    it "approved/rejects pets on one application do not affect other applications" do 
      shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      clawdia = shelter.pets.create!(name: "Clawdia", breed: "tuxedo shorthair", age: 5, adoptable: true)
      simon = clawdia.applications.create!(applicant: "Simon", address: "123 Sesame Street, Denver, CO 80212", description: "I am cool")
      erin = clawdia.applications.create!(applicant: "Erin", address: "2303 East West Drive, Denver, CO 80205", description: "I have a roof")

      visit "/admin/applications/#{simon.id}"

      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      click_button "Reject"

      visit "/admin/applications/#{erin.id}"

      expect(page).to_not have_content("Pet Application Status: Approved")
      expect(page).to_not have_content("Pet Application Status: Rejected")
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end
end
