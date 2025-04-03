class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campsite, only: [ :create, :destroy ]

  def index
    @campsites = current_user.favorite_campsites
  end

  def create
    current_user.add_favorite(@campsite)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @campsite, notice: "お気に入りに追加しました。" }
    end
  end

  def destroy
    current_user.remove_favorite(@campsite)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @campsite, notice: "お気に入りを解除しました。" }
    end
  end

  private

  def set_campsite
    @campsite = Campsite.find_by(id: params[:campsite_id])
  end
end
