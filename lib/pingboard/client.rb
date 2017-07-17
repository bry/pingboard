module Pingboard
  class Client

    URL_HOSTNAME = 'https://app.pingboard.com'.freeze
    URL_API_VERSION_PATH = '/api/v2'.freeze
    URL_SEARCH_USERS_PATH = '/search/users'.freeze
    URL_USERS_PATH = '/users'.freeze
    URL_STATUSES_PATH = '/statuses'.freeze
    URL_STATUS_TYPES_PATH = '/status_types'.freeze
    URL_OAUTH_TOKEN_PATH = '/oauth/token'.freeze

    attr_accessor :connection, :service_app_id, :service_app_secret,
      :access_token, :token_expires_in, :token_expiration_time

    def initialize(options={})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      @token_expiration_time = Time.now
    end

    def search(query, options={})
      options.merge(q: query)
      perform_get_request(URL_API_VERSION_PATH + URL_SEARCH_USERS_PATH, options)
    end

    def users(options={})
      perform_get_request(URL_API_VERSION_PATH + URL_USERS_PATH, options)
    end

    def user(user_id, options={})
      perform_get_request(URL_API_VERSION_PATH + URL_USERS_PATH + "/#{user_id}", options)
    end

    def status(status_id, options={})
      perform_get_request(URL_API_VERSION_PATH + URL_STATUSES_PATH + "/#{status_id}", options)
    end

    def status_types
      perform_get_request(URL_API_VERSION_PATH + URL_STATUS_TYPES_PATH)
    end


    private

    def connection
      @connection = Faraday.new(url: URL_HOSTNAME)
    end

    def access_token_expired?
      Time.now > token_expiration_time
    end

    def new_access_token
      response_body = JSON.parse(access_token_request.body)
      @token_expires_in = response_body['expires_in']
      @token_expiration_time = Time.now + @token_expires_in.to_i
      response_body['access_token']
    end

    def access_token
      @access_token = new_access_token if access_token_expired?
      @access_token
    end

    def access_token_request
      @access_token_request = connection.post do |req|
        req.url URL_OAUTH_TOKEN_PATH
        req.params['grant_type'] = 'client_credentials'
        req.body = {
          client_id: service_app_id,
          client_secret: service_app_secret
        }
      end
    end

    def perform_get_request(url_path, options={})
      pingboard_response = connection.get do |req|
        req.url "#{url_path}"
        req.headers['Authorization'] = "Bearer #{access_token}"
        options.each do |key, value|
          req.params["#{key}"] = value
        end
      end

      JSON.parse(pingboard_response.body)
    end
  end
end
