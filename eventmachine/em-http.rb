# igvita.com :: Ilya Grigorik
# May 24, '08

require 'rubygems'
require 'eventmachine'
require 'evma_httpserver'

class Handler  < EventMachine::Connection
  include EventMachine::HttpServer

  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )

    sleep 2 # Simulate a long running request

    resp.status = 200
    resp.content = "Hello World!"
    resp.send_response
  end
end

EventMachine::run {
  EventMachine.epoll
  EventMachine::start_server("0.0.0.0", 8080, Handler)
  puts "Listening..."
}

# Benchmarking results:
#
# > ab -c 5 -n 10 "http://127.0.0.1:8080/"
# > Concurrency Level:      5
# > Time taken for tests:   20.6246 seconds
# > Complete requests:      10
