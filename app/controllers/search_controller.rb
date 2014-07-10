class SearchController < ApplicationController
  helper_method :searchForNearbyBusinesses

  $candidates = []

  def findBusinesses(candidates)
    # TODO: actually implement this
    return candidates
  end

  def findCustomers(candidates)
    return candidates
  end

  def searchForNearbyBusinesses(distance=5000, category=nil)
    business = searchForBusiness(session["current_locu_id"])
    coordinates = business["location"]["geo"]["coordinates"]
    fields = ["name", "location", "contact", "categories", "media"]
    queries = [
      {
        location: {
          geo: {
            "$in_lat_lng_radius" => [coordinates[1], coordinates[0], distance]
          }
        }
      }
    ]

    results = searchLocu(fields, queries)["venues"]
    if params[:type] == 'customer'
      $candidates = findCustomers(results)
    else
      $candidates = findBusinesses(results)
    end
    render 'results'
  end

  def sendMessage
    content = params[:content]
    sender_id = session["current_locu_id"]
    receiver_id = $candidates[params[:receiver_id].to_i]["locu_id"]
    message = Message.create(content: content, sender_id: sender_id, receiver_id: receiver_id)
    # TODO: redirect to matches
    redirect_to messages_path
  end

  def reject
    $candidates.shift
  end

  def accept
    match = Match.new
    match.sender_id = session["current_locu_id"]
    match.receiver_id = $candidates[0]["locu_id"]
    #match.accepted = false
    byebug
    # TODO: redirect if match exists, otherwise make match
  end

  def index
    $candidates = []
  end

  def results
    if $candidates.empty?
      redirect_to search_path
    end
  end

end
