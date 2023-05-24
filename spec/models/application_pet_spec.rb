require "rails_helper"

RSpec.describe ApplicationPet, type: :model do 
  describe "relationship" do 
    it { should belong_to :application }
    it { should belong_to :pet }
  end
end
