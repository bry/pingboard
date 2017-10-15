module Pingboard
  class Client
    URL_HOSTNAME = 'https://app.pingboard.com'.freeze
    URL_API_VERSION_PATH = '/api/v2'.freeze
    URL_SEARCH_USERS_PATH = '/search/users'.freeze
    URL_USERS_PATH = '/users'.freeze
    URL_STATUSES_PATH = '/statuses'.freeze
    URL_STATUS_TYPES_PATH = '/status_types'.freeze
    URL_OAUTH_TOKEN_PATH = '/oauth/token'.freeze

    attr_accessor :service_app_id, :service_app_secret, :token_expires_in,
      :token_expiration_time

    def initialize(request = Pingboard::Request, options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      @token_expiration_time = Time.now
      @request = request
    end

    def search(query, options = {})
      options[:q] = query
      response = build_request(
        self,
        :get,
        URL_API_VERSION_PATH + URL_SEARCH_USERS_PATH,
        { 'Authorization' => "Bearer #{access_token}" },
        nil,
        options
      ).do
      JSON.parse(response.body)
    end

    def users(options = {})
      response = build_request(
        self,
        :get,
        URL_API_VERSION_PATH + URL_USERS_PATH,
        { 'Authorization' => "Bearer #{access_token}" },
        nil,
        options
      ).do
      JSON.parse(response.body)
    end

    def user(user_id, options = {})
      response = build_request(
        self,
        :get,
        URL_API_VERSION_PATH + URL_USERS_PATH + "/#{user_id}",
        { 'Authorization' => "Bearer #{access_token}" },
        nil,
        options
      ).do
      JSON.parse(response.body)
    end

    def status(status_id, options = {})
      response = build_request(
        self,
        :get,
        URL_API_VERSION_PATH + URL_STATUSES_PATH + "/#{status_id}",
        { 'Authorization' => "Bearer #{access_token}" },
        nil,
        options
      ).do
      JSON.parse(response.body)
    end

    def status_types
      response = build_request(
        self,
        :get,
        URL_API_VERSION_PATH + URL_STATUS_TYPES_PATH,
        { 'Authorization' => "Bearer #{access_token}" },
        nil,
        nil
      ).do
      JSON.parse(response.body)
    end

    def connection
      @connection = Faraday.new(url: URL_HOSTNAME)
    end

    def access_token
      @access_token = new_access_token if access_token_expired?
      @access_token
    end

  private

    def build_request(client, http_verb, path, headers, body, params)
      @request.new(
        client: client,
        http_verb: http_verb,
        path: path,
        headers: headers,
        body: body,
        params: params
      )
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

    def access_token_request
      @access_token_request = build_request(
        self,
        :post,
        URL_OAUTH_TOKEN_PATH,
        { 'Content-Type' => 'application/x-www-form-urlencoded' },
        { 'client_id' => service_app_id.to_s, 'client_secret' => service_app_secret.to_s },
        'grant_type' => 'client_credentials'
      ).do
    end
  end
end
