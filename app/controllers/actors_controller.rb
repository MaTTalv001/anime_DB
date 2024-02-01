class ActorsController < ApplicationController
  def index
    @q = Actor.ransack(params[:q])
    @actors = @q.result(distinct: true).order(created_at: :desc).includes(:works).page(params[:page])
  end
end
