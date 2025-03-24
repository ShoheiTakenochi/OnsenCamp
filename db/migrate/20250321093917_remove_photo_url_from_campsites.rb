class RemovePhotoUrlFromCampsites < ActiveRecord::Migration[7.2]
  def change
    remove_column :campsites, :photo_url, :string
  end
end
