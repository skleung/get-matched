class ProfileController < ApplicationController
  def index
    @business = searchForBusiness(session["current_locu_id"])
    coordinates = @business["location"]["geo"]["coordinates"]
    fields = ["name", "location", "contact", "categories", "media"]
    queries = [
      {
        location: {
          geo: {
            "$in_lat_lng_radius" => [coordinates[1], coordinates[0], 99999]
          }
        },
        media: {"$present" => true}
      }
    ]

    @results = searchLocu(fields, queries)['venues'].find('categories')
  end

  def edit
    @business = searchForBusiness(session["current_locu_id"])
    render 'edit'
  end

  def submit
    user = User.where(locu_str_id: session["current_locu_id"]).first
    user.update_attribute(:categories, params[:category_update])
    user.update_attribute(:needs, params[:needs_update])
    redirect_to profile_path, notice: 'Successfully updated profile'
  end
end
