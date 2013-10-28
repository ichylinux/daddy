# coding: UTF-8

require 'faraday'

module Daddy
  class HttpClient
  
    def initialize(url, options = {})
      @url = url
      @options = options
      @cookie = nil
      Rails.logger.debug "[HttpClient] url: #{@url}"
    end
    
    def get(path, params = {})
      Rails.logger.debug "[HttpClient] path: #{path}"
      Rails.logger.debug "[HttpClient] params: #{params}"

      response = connection.get(path, params) do |request|
        if @options[:auth_user] and @options[:auth_password]
          basic = Base64.encode64(@options[:auth_user] + ':' + @options[:auth_password])
          request.headers['Authorization'] = 'Basic ' + basic
        end
        
        if @cookie
          Rails.logger.debug "[HttpClient] cookie: #{@cookie}"
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
        Rails.logger.debug "[HttpClient] stutus: #{response.status}"
        response.body.force_encoding('UTF-8')
      end
    end
  
    def post(path, params = {})
      response = connection.post(path, params)
    end

    private
  
    def connection
      Faraday.new(:url => @url, :ssl => ssl_options) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
    
    def ssl_options
      lib_dir = File.expand_path('../..', __FILE__)
      ca_path = File.join(lib_dir, 'ssl')
  
      ret = {
        :ca_path => ca_path,
        :ca_file => File.join(ca_path, 'cert.pem'),
        :verify => @options[:verify_ssl] || false,
      }
    end
  end
end
