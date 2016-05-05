class HomeController < ApplicationController
  def index
    @date = Time.zone.now
  end
end
