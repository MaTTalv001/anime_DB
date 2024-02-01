class WorksController < ApplicationController
  def index
    @q = Work.ransack(params[:q])
    @works = @q.result(distinct: true).order(created_at: :desc).includes(:actors).page(params[:page])
  end
end
