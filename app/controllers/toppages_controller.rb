class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end
end