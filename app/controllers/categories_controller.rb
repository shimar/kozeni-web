class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.where("name like ?", params[:q] + '%')
  end
end
