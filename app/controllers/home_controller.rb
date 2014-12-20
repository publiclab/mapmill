class HomeController < ApplicationController
  def front
    @sites = Site.offset(rand(Site.count)).limit(3)
  end
end
