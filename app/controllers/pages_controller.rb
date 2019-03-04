class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def video
    @session_id = params[:session_id]
    @token = params[:token]
  end

end
