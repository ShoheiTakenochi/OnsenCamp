class ProfileImageUploader < CarrierWave::Uploader::Base
  
  storage :file
  
  include CarrierWave::MiniMagick
  process resize_to_fit: [150, 150]

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 許可する拡張子
  def extension_allowlist
    %w[jpg jpeg png]
  end
  
end
