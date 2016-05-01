class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    render layout: 'unsigned'
  end

  def create
    render layout: 'unsigned'
  end
end
