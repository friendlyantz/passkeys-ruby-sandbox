class HomeController < ApplicationController
  before_action :enforce_current_user
  def index; end

  def enforce_current_user
    return unless current_user.blank?

    redirect_to new_session_path
  end
end
