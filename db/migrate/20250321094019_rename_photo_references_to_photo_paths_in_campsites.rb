class RenamePhotoReferencesToPhotoPathsInCampsites < ActiveRecord::Migration[7.2]
  def change
    rename_column :campsites, :photo_references, :photo_paths
  end
end
