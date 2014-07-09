class WelcomeController < ApplicationController
  def index
  end

  def login
    username = params[:username]
    user = User.where(username: username)
    if user
      session['current_locu_id'] = user.locu_str_id

    else
      redirect_to root_url, alert: "Couldn't find that username!"
    end
  end

  def signup
    User.where(username: params[:username], locu_str_id:).first_or_create
  end
end