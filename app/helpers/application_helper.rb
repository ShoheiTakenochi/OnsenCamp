module ApplicationHelper
  def photo_paths_array(record)
    return [] unless record.photo_paths.present?

    begin
    JSON.parse(record.photo_paths)
    rescue JSON::ParserError
    []
    end
  end

  def main_image_url(record)
    paths = photo_paths_array(record)
    paths.any? ? url_for("/#{paths.first}") : nil
  end

  def sub_image_urls(record)
    return [] unless record.photo_paths.present?

    begin
      paths = JSON.parse(record.photo_paths)
      paths.is_a?(Array) ? paths[1..3] || [] : []
    rescue JSON::ParserError
      []
    end
  end
end