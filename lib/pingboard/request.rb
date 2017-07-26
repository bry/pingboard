module Pingboard
  class Request

    attr_accessor :client, :path, :http_verb

    def initialize(client, http_verb, path, options={})
      @client = client
      @http_verb = http_verb
      @path = path
      @options = options
    end

    def do
      @client.connection.public_send(@http_verb) do |req|
        req.url "#{@path}"
        req.headers['Authorization'] = "Bearer #{@client.access_token}"
        @options.each do |key, value|
          req.params["#{key}"] = value
        end
      end
    end

  end
end
