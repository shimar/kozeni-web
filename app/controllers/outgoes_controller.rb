class OutgoesController < ApplicationController
  layout false

  def index
  end

  def show
  end

  def create
    category_name = outgo_params[:category]
    category = current_user.categories.find_or_create_by(name: category_name)
    @outgo = Outgo.new(user_id: current_user.id, date: outgo_params[:date], amount: outgo_params[:amount])
    @outgo.category = category
    @outgo.save
  end

  def update
  end

  def destroy
  end

  private

  def outgo_params
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
