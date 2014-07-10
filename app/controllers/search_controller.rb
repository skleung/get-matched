class SearchController < ApplicationController
  helper_method :searchForNearbyBusinesses

  $candidates = []

  def findBusinesses(candidates)
    my_id = session["current_locu_id"]
    candidates.each do |candidate|
      if !Match.where(sender_id: candidate["locu_id"], receiver_id: my_id,
                      accepted: false, selling: true).empty?
        candidate["confidence"] = 1.0
      else
        candidate["confidence"] = 0.5
      end
    end
    return candidates.sort { |c1, c2| c2["confidence"] <=> c1["confidence"] }
  end

  def findCustomers(candidates)
    my_id = session["current_locu_id"]
    candidates.each do |candidate|
      if !Match.where(sender_id: candidate["locu_id"], receiver_id: my_id,
                      accepted: false, selling: false).empty?
        candidate["confidence"] = 1.0
      else
        candidate["confidence"] = 0.5
      end
    end
    return candidates.sort { |c1, c2| c2["confidence"] <=> c1["confidence"] }
  end

  def searchForNearbyBusinesses(distance=1000, category=nil)
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
    # Filter out my own business
    results.select! {|result| result["locu_id"] != session["current_locu_id"]}
    if params[:type] == 'customer'
      $candidates = findCustomers(results)
    else
      $candidates = findBusinesses(results)
    end
    render 'results'
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
      match.save

    elsif (matches.first.selling != selling) || (!matches.first.selling && !selling)
      # Otherwise, if a match exists, only accept it if
      # I'm buying and she's selling, or I'm selling and she's buying
      # or if we are both buying
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
