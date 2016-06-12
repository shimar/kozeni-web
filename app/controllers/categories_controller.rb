class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
    @categories = @categories.where("name like ?", pamaras[:q] + '%') if params.key?(:q)
  end
end
