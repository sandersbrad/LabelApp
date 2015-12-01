class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :to_name, null: false
      t.string :to_street_1, null: false
      t.string :to_street_2
      t.string :to_zip
      t.string :to_city
      t.string :to_state
      t.string :to_country, limit: 2, default: 'US'
      t.string :to_email

      t.string :from_name, null: false
      t.string :from_street_1, null: false
      t.string :from_street_2
      t.string :from_zip
      t.string :from_city
      t.string :from_state
      t.string :from_country, limit: 2, default: 'US'
      t.string :from_email
      t.string :from_phone

      t.float :parcel_length, null: false
      t.float :parcel_width, null: false
      t.float :parcel_weight, null: false
      t.float :parcel_height, null: false

      t.string :label_url

      t.timestamps null: false
    end
  end
end
