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
      @test = @client.connection.public_send(@http_verb) do |request|
        request.url "#{@path}"
        set_headers!(request) if headers
        set_body!(request) if body
        set_params!(request) if params
      end
      @test
    end

    private

    def set_body!(request)
      request.body = body
    end

    def set_headers!(request)
      headers.each { |key, value| request.headers["#{key}"] = value }
    end

    def set_params!(request)
      params.each { |key, value| request.params["#{key}"] = value }
    end

  end
end
