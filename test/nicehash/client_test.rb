require "test_helper"
require 'faraday'

class Nicehash::ClientTest < Minitest::Test
  def test_client
    http_client = Faraday.new do |builder|
      builder.response :json, parser_options: { symbolize_names: true }
      builder.adapter :test, client_stub
    end

    addr = '17a212wdrvEXWuipCV5gcfxdALfMdhMoqh'

    client = ::Nicehash::Client.new(client: http_client)
    resp = client.api
    assert resp
    assert resp.method == nil
    assert resp.result

    resp = client.stats_global_current
    assert resp
    assert resp.method == 'stats.global.current'
    assert resp.result

    resp = client.stats_global_24h
    assert resp
    assert resp.method == 'stats.global.24h'
    assert resp.result

    resp = client.stats_provider(addr: addr)
    assert resp
    assert resp.method == 'stats.provider'
    assert resp.result

    resp = client.stats_provider_ex(addr: addr, from: 1111111)
    assert resp
    assert resp.method == 'stats.provider.ex'
    assert resp.result

    resp = client.stats_provider_payments(addr: addr)
    assert resp
    assert resp.method == 'stats.provider.payments'
    assert resp.result

    resp = client.stats_provider_workers(addr: addr, algo: :x11)
    assert resp
    assert resp.method == 'stats.provider.workers'
    assert resp.result
  end

  private

  def client_stub
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/api') do |env| 
        headers = { 'Content-Type' => 'application/json' }
        method = env.params['method']

        status = 200
        case method
        when nil
          body = '{"result":{"api_version":"1.0.1"},"method":null}'
        when 'stats.global.current',
          'stats.global.24h',
          'stats.provider',
          'stats.provider.ex',
          'stats.provider.payments',
          'stats.provider.workers'
          body = open(File.join(__dir__, "../data/#{method.gsub('.', '_')}.json")).read
        else
          status = 404
          body = '{}'
        end
        [status, headers, body] 
      end
    end
  end
end
