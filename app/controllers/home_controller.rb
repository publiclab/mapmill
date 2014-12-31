class HomeController < ApplicationController
  def front
    @sites = Site.order('id DESC').paginate(:page => params[:page], :per_page => 8)
  end
end
