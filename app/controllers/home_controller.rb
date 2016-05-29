class HomeController < ApplicationController
  def index
    @date = Time.zone.now
    @item = ItemForm.new(user_id: current_user.id, date: @date)
    @incomes = current_user.incomes.includes(:category).ym(@date)
    @outgoes = current_user.outgoes.includes(:category).ym(@date)
  end
end
