class UserController < ApplicationController
  def signup
    user_query = User.where(username: params[:user][:username])
    if user_query.count != 0
      user = user_query.first
      redirect_to root_url, alert: "oops that username is already registered with locu id #{user.locu_str_id}" and return
    end
    user = User.where(params[:user]).create
    session['current_locu_id'] = user.locu_str_id
    session['current_userid'] = user.id
    redirect_to search_path, notice: "Signed up with username #{user.username}, locu id #{user.locu_str_id}"
  end

  def login
    username = params[:user][:username]
    user_query = User.where(username: username)
    if user_query.count != 0
      user = user_query.first
      session['current_locu_id'] = user.locu_str_id
      session['current_userid'] = user.id
      redirect_to search_path, notice: "logged in with locu id #{user.locu_str_id}"
    else
      redirect_to root_url, alert: "Couldn't find username #{username}!"
    end
  end

  def logout
    session['current_locu_id'] = nil
    session['current_userid'] = nil
  end

  def show
    locu_id = params[:locu_id]
    locu_buisness = searchForBusiness(locu_id)
  end
end