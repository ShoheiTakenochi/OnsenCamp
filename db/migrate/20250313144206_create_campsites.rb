class CreateCampsites < ActiveRecord::Migration[7.2]
  def change
    create_table :campsites do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
