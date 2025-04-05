class MetaController < ApplicationController
  def campsite
    @campsite = Campsite.find(params[:id])
    render layout: "meta"
  end
end
