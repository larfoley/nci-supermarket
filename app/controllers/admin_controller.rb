class AdminController < ApplicationController
  before_action :authenticate_admin

  layout "dashboard"

  def index
    redirect_to admin_products_path
  end

  private

  def authenticate_admin
    if !current_user.admin then
      redirect_to root_path
    end
  end
end
