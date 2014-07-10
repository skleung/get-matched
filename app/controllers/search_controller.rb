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

  def searchForNearbyBusinesses(distance=99999999, category=nil)
    business = searchForBusiness(session["current_locu_id"])
    coordinates = business["location"]["geo"]["coordinates"]
    fields = ["name", "location", "contact", "categories", "media"]
    queries = [
      {
        location: {
          geo: {
            "$in_lat_lng_radius" => [coordinates[1], coordinates[0], distance]
          }
        },
        media: {"$present" => true}
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
    render :nothing => true
  end

  def accept
    candidate_id = $candidates[0]["locu_id"]
    user_id = session["current_locu_id"]
    selling = (params[:type] == 'customer')

    matches = Match.where(sender_id: candidate_id, receiver_id: user_id)
    if matches.empty?
      # Create a match if no match already exists
      match = Match.new
      match.sender_id = user_id
      match.receiver_id = candidate_id
      match.accepted = false
      match.selling = selling
      if !match.save
        flash[:alert] = "Match cannot be made!"
      else
        flash[:notice] = "Match made!"
      end
    elsif matches.first.selling != selling
      # Otherwise, if a match exists, only accept it if
      # I'm buying and she's selling, or I'm selling and she's buying
      match = matches.first
      match.accepted = true
      match.save

      # Autogenerate two messages
      message = Message.new
      message.sender_id = match.sender_id
      message.receiver_id = match.receiver_id
      message.content = "You've been matched!"
      message.save

      message = Message.new
      message.sender_id = match.receiver_id
      message.receiver_id = match.sender_id
      message.content = "You've been matched!"
      message.save

      render :js => "window.location = '#{messages_path}?locu_id=#{candidate_id}'"
      return
    end
    $candidates.shift
    render :nothing => true
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
