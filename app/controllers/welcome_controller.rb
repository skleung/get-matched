class WelcomeController < ApplicationController

  skip_before_filter :require_login
  def index
  	if logged_in?
  		redirect_to search_path
  	end
  end
end