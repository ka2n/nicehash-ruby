require 'faraday'
require 'faraday_middleware'

module Nicehash
  class Client
    def initialize(client: nil)
      @client = client || Faraday.new('https://api.nicehash.com/api') do |conn|
        conn.response :json, parser_options: { symbolize_names: true }
        conn.adapter Faraday.default_adapter
      end
    end

    def api
      resp = rpc(nil)
      Response.from_faraday_resp(resp)
    end

    def method_missing(name, *args, **kwargs)
      resp = rpc(name.to_s.gsub('_', '.'), kwargs)
      Response.from_faraday_resp(resp)
    end

    private

    def rpc(method, **kwargs)
      params = {}
      params[:method] = method if method
      params.merge! kwargs
      @client.get '/api', params
    end
  end

  class Response
    attr_reader :method, :result, :error

    def self.from_faraday_resp(resp)
      body = resp.body
      error = body&.dig(:result, :error)
      result = error ? nil : body[:result]
      self.new(body[:method], result, error)
    end

    def initialize(method, result = nil, error = nil)
      @method =  method
      @result = result
      @error = error
    end

    def ok?
      @error == nil
    end
  end
end