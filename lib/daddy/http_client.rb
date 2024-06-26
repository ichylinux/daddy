require 'faraday'

module Daddy
  
  class HttpClient
  
    def initialize(url, options = {})
      @url = url
      @options = options
      @cookie = options[:cookie]
    end
    
    def get(path, params = {})
      response = connection.get(path, params) do |request|
        if @options[:auth_user] and @options[:auth_password]
          basic = 'Basic ' + Base64.encode64(@options[:auth_user] + ':' + @options[:auth_password])
          request.headers['Authorization'] = basic
        end

        if @cookie
          request.headers['Cookie'] = @cookie
        end

        params.each do |key, value|
          request.params[key] = value
        end
      end

      @cookie = response.headers['set-cookie']

      if block_given?
        yield response
      else
        response.body
      end
    end

    def post(path, params = {})
      response = connection.post(path, params)
    end

    private

    def connection
      Faraday.new(url: @url, ssl: ssl_options) do |faraday|
        faraday.request :url_encoded
        faraday.use FaradayMiddleware::FollowRedirects if @options[:follow_redirects]
        faraday.adapter Faraday.default_adapter
      end
    end
    
    def ssl_options
      {
        verify: @options.fetch(:verify_ssl, true)
      }
    end

  end
end
