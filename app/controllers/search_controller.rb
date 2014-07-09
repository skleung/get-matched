class SearchController < ApplicationController
  helper_method :searchForNearbyBusinesses

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
    return results["venues"]
  end

  def index
    # TODO: use User.locu_str_id
    locu_id = '03cdacebde7c11285270'
    @businesses = searchForNearbyBusinesses(locu_id)
  end
end
