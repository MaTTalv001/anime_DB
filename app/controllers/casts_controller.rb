class CastsController < ApplicationController
  def index
    @casts = Cast.all.page(params[:page])
  end
end
