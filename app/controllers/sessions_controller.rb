class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
    render layout: 'unsigned'
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: 'Signin successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new', layout: 'unsigned'
    end
  end

  def destroy
    logout
    redirect_to welcome_path, notice: 'Signout.'
  end

end
