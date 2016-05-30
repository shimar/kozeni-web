class HomeController < ApplicationController
  def index
    @date = Time.zone.now
    @balances = build_balances
    @item = ItemForm.new(user_id: current_user.id, date: @date)
    @incomes = current_user.incomes.includes(:category).ym(@date).amount_by_day
    @outgoes = current_user.outgoes.includes(:category).ym(@date).amount_by_day

    @sum_incomes = current_user.incomes.ym(@date).sum_amount
    @sum_outgoes = current_user.outgoes.ym(@date).sum_amount

    @incomes.each do |i|
      @balances[i[0]][:incomes]= i[1]
    end
    @outgoes.each do |o|
      @balances[o[0]][:outgoes]= o[1]
    end
  end

  private

  def build_balances
    beginning_of_month = @date.beginning_of_month.to_date
    end_of_month       = @date.end_of_month.to_date
    day_count = (end_of_month - beginning_of_month).to_i
    t = {}
    (0..day_count).each { |d| t[beginning_of_month + d.days] = { incomes: 0, outgoes: 0 } }
    t
  end

end
