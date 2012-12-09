require 'rubygems'
require 'net/http'
require 'json'

module HackerNews
  class Api
    attr_accessor :http_code

    HACKERNEWS_URL = 'http://api.ihackernews.com'

    def front_page
      get_page("/page")
    end

    # class method
    def get_page(page)
      resp = Net::HTTP.get_response(URI.parse(HACKERNEWS_URL + "#{page}"))

      @http_code = resp.code
      return nil  unless resp.code == "200"

      data = resp.body

      # Array of HNews
      JSON.parse(data)['items']
    end
  end
end
