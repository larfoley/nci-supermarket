class Admin::ActivityController < ApplicationController
  def index
    @page_requests = ActivityLogger.instance.get_page_requests
  end
end
