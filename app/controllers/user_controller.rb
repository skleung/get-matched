class UserController < ApplicationController
  def create
    User.where(username: params[:user][:username], locu_str_id: params[:user][:locu_str_id]).first_or_create
  end

  def login
    username = params[:username]
    user = User.where(username: username)
    if user
      session['current_locu_id'] = user.locu_str_id
      flash[:success] = "logged in with #{user.locu_str_id}"
    else
      redirect_to root_url, alert: "Couldn't find that username!"
    end
  end
end