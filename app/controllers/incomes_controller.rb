class IncomesController < ApplicationController
  layout false

  def create
    @status = 201
    category_name = income_params[:category]
    category = current_user.categories.find_or_create_by(name: category_name)
    @income = Income.new(user_id: current_user.id, date: income_params[:date], amount: income_params[:amount])
    @income.category = category
    @status = 422 unless @income.save
    render status: @status
  end

  private

  def income_params
    params.require(:item_form).permit(
      :id,
      :user_id,
      :category,
      :date,
      :amount,
      :planned
    )
  end

end
