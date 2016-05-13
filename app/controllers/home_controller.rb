class HomeController < ApplicationController
  def index
    @date = Time.zone.now
    @item = ItemForm.new(user_id: current_user.id, date: @date)
  end
end
