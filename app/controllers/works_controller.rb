class WorksController < ApplicationController
  def index
    @works = Work.page(params[:page])
  end
end
