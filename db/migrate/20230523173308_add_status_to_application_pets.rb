class AddStatusToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :ap_status, :string, default: "Pending", null: false
  end
end
