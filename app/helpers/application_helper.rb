module ApplicationHelper
  def photo_paths_array(record)
    return [] unless record.images.attached?

    record.images.map { |image| url_for(image) }
  end

  def main_image_url(record)
    if record.images.attached?
      url_for(record.images.first)
    else
      asset_path("default_campsite.PNG") # デフォルト画像
    end
  end
end
