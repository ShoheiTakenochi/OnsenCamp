class CampsitesController < ApplicationController
  def show; end

  def index
    @q = Campsite.ransack(params[:q])
    @campsites = @q.result(distinct: true)
  end
end
