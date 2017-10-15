module Pingboard
  class Request
    attr_accessor :client, :path, :http_verb, :headers, :body, :params

    def initialize(client:, http_verb:, path:, headers:, body:, params: {})
      @client = client
      @http_verb = http_verb
      @path = path
      @headers = headers
      @body = body
      @params = params
    end

    def do
      @client.connection.public_send(@http_verb) do |request|
        request.url @path.to_s
        headers!(request) if headers
        body!(request) if body
        params!(request) if params
      end
    end

  private

    def body!(request)
      request.body = body
    end

    def headers!(request)
      headers.each { |key, value| request.headers[key.to_s] = value }
    end

    def params!(request)
      params.each { |key, value| request.params[key.to_s] = value }
    end
  end
end
