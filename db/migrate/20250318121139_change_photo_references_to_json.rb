class ChangePhotoReferencesToJson < ActiveRecord::Migration[7.2]
  def change
    change_column :campsites, :photo_references, :jsonb, using: 'photo_references::jsonb'
  end
end
