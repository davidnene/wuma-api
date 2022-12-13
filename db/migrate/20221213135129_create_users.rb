class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :msidn
      t.string :location
      t.string :user_type
      t.string :verification_status

      t.timestamps
    end
  end
end
