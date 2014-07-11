class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :phone2
      t.string :fax
      t.string :address
      t.string :address2
      t.string :city, default: "Brooklyn"
      t.string :state, default: "NY"
      t.string :country, default: "US"
      t.string :zip
      t.string :contact_preference, default: "email"
      t.string :gender
      t.string :status
      t.date :join_date, null: false
      t.date :date_of_birth
      t.date :on_hold_until
      t.boolean :admin, default: false
      t.boolean :membership_agreement, default: false
      t.float :monthly_hours, default: 4.0
      t.float :membership_discount, default: 0.0
      t.float :investment_discount, default: 0.0

      t.timestamps
    end

    add_index :members, [:first_name, :middle_name, :last_name], unique: true

  end
end