class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :applicant
      t.string :address
      t.string :description
      t.string :status, default: "In Progress", null: false

      t.timestamps
    end
  end
end
