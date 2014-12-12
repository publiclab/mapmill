class HomeController < ApplicationController
  def front
    @sites = Site.joins(:images).where("images.id IS NOT NULL").uniq.order("RANDOM()").limit(3)
  end
end
