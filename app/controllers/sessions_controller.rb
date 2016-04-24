class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    render layout: 'unsigned'
  end

  def create
  end

  def destroy
  end

end
