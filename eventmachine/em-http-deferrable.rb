# igvita.com :: Ilya Grigorik
# May 24, '08

require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'

class Handler  < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )

    # query our threaded server (max concurrency: 20)
    http = EM::Protocols::HttpClient.request(
              :host=>"localhost",
              :port=>8081,
              :request=>"/"
           )

    # once download is complete, send it to client
    http.callback do |r|
        resp.status = 200
        resp.content = r[:content]
        resp.send_response
    end

  end
end

EventMachine::run {
  EventMachine.epoll
  EventMachine::start_server("0.0.0.0", 8082, Handler)
  puts "Listening..."
}

# Benchmarking results:
#
# > ab -c 20 -n 40 "http://127.0.0.1:8082/"
# > Concurrency Level:      20
# > Time taken for tests:   4.41321 seconds
# > Complete requests:      40