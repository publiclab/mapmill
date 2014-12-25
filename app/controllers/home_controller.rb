class HomeController < ApplicationController
  def front
    @sites = Site.joins(:images).where("images.id IS NOT NULL").offset(rand(Site.count-1)).limit(12)
  end
end
