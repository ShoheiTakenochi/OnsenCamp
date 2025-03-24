class CreateHotsprings < ActiveRecord::Migration[7.2]
  def change
    create_table :hotsprings do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.boolean :parking
      t.boolean :sauna
      t.boolean :open_air_bath
      t.string :photo_url

      t.timestamps
    end
  end
end
