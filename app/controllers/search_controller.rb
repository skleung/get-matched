class SearchController < ApplicationController
  helper_method :searchForNearbyBusinesses

  $businesses = []

  def rankBusinesses(businesses)
    # TODO: actually implement this
    return businesses
  end

  def searchForNearbyBusinesses(locu_id, distance=5000, category=nil)
    business = searchForBusiness(locu_id)
    coordinates = business["location"]["geo"]["coordinates"]
    fields = ["name", "location", "contact", "categories"]
    queries = [
      {
        location: {
          geo: {
            "$in_lat_lng_radius" => [coordinates[1], coordinates[0], distance]
          }
        }
      }
    ]

    results = searchLocu(fields, queries)
    return rankBusinesses(results["venues"])
  end

  def sendMessage
    content = params[:content]
    sender_id = session["current_user_id"]
    receiver_id = $businesses[params[:receiver_id].to_i]["locu_id"]
    p receiver_id
    # TODO: Save message!
    #message = Message.new(content=content, sender_id=sender_id, receiver_id=receiver_id)
    #message.save!
    # TODO: redirect to matches
    redirect_to search_path
  end

  def index
    locu_id = session["current_locu_id"]
    $businesses = searchForNearbyBusinesses(locu_id)
    @message = Message.new
  end
end
