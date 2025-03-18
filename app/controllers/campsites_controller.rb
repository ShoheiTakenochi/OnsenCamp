class CampsitesController < ApplicationController
  def show; end

  def index
    @q = Campsite.ransack(params[:q])
    @campsites = @q.result(distinct: true)

    if params[:q] && params[:q][:address_cont].present?
      address = params[:q][:address_cont]
      geocoding_api_key = ENV["GOOGLE_MAPS_API_KEY"]
      geocoding_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode_www_form_component(address)}&key=#{geocoding_api_key}"

      uri = URI(geocoding_api_url)
      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        results = JSON.parse(response.body)
        if results["results"].present?
          location = results["results"][0]["geometry"]["location"]
          @center_lat = location["lat"]
          @center_lng = location["lng"]
        end
      end
    end

    @center_lat ||= 35.6895 # デフォルト値（東京）
    @center_lng ||= 139.6917 # デフォルト値（東京）
  end
end
