module ApplicationHelper
  def searchForNearbyBuisness(locu_id, category = nil)
    url = 'https://api.locu.com'
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/v2/venue/search")
    data = {
          api_key: "fb7523f94c32524215421f2a00ded5e01727b303",
          fields: [ "name", "menu_items" ],
          venue_queries: [
            {
              location: {
                locality: "Boston"
              }
            }
          ],
          menu_item_queries: [
            {
              name: "pizza"
            }
          ]
        }
    request.body = data.to_json
    request.add_field('Content-Type', 'application/json')
    response = http.request(request)
    response.body
  end
end
