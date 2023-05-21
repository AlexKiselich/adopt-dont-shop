require "rails_helper"

RSpec.describe Application, type: :model do 
  describe "relationship" do 
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:applicant) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:description) }
  end
end