class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
    @categories = @categories.where("name like ?", params[:q] + '%') if params.key?(:q)
  end
end
