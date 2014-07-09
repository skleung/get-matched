class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception

class LocuAPIError < RuntimeError
end

  def searchLocu(fields, queries)
    api_key = "fb7523f94c32524215421f2a00ded5e01727b303"
    url = 'https://api.locu.com'
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/v2/venue/search")

    data = {
      api_key: api_key,
      fields: fields,
      venue_queries: queries
    }
    request.body = data.to_json
    request.add_field('Content-Type', 'application/json')
    response = http.request(request)
    results = JSON.parse(response.body)

    if results["status"] == "error"
      raise LocuAPIError, results["error"]
    end

    return results
  end

  def searchForBusiness(locu_id)
    fields = ["name", "location", "contact"]
    queries = [{ locu_id: locu_id }]
    results = searchLocu(fields, queries)

    if results["venues"].empty?
      return nil
    else
      return results["venues"][0]
    end
  end

end
