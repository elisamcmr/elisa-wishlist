class ApplicationController < ActionController::Base
  private

  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
