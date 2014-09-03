class HomeController < ApplicationController
  def front
    @sites = Site.order("RANDOM()").limit(3)
  end
end
