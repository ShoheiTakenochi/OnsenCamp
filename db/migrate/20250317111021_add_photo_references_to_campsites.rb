class AddPhotoReferencesToCampsites < ActiveRecord::Migration[7.2]
  def change
    add_column :campsites, :photo_references, :text
  end
end
