module ApplicationHelper
  def searchForNearbyBuisness(locu_id, distance = 5000, category = nil)
    api_key = "fb7523f94c32524215421f2a00ded5e01727b303"
    url = 'https://api.locu.com'
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/v2/venue/search")
    data = {
          api_key: api_key,
          fields: [ "name", "location", "contact" ],
          venue_queries: [
            {
              locu_id: locu_id
            }
          ]
        }
    request.body = data.to_json
    request.add_field('Content-Type', 'application/json')
    response = http.request(request)
    results = response.body
    json_results = JSON.parse(results)
    buisness = json_results["venues"][0]
    coordinate = buisness["location"]["geo"]["coordinates"]

    data = {
      api_key: api_key,
      fields: [ "name", "location", "contact" ],
      venue_queries: [
        {
          location: {
            geo: {
              "$in_lat_lng_radius" => [coordinate[1], coordinate[0], distance]
            }
          }
        }
      ]
    }

    request.body = data.to_json
    response = http.request(request)
    response.body
  end
end
