require "http/server"
require "anyolite"

class Request
  def handle
    print "+"
    sleep 0.1
    print "-"
  end
end

Anyolite::RbInterpreter.create do |rb|
  Anyolite.wrap(rb, Request)

  server = HTTP::Server.new do |context|
    context.response.content_type = "text/plain"
  
    rb.execute_script_line("Request.new.handle")  
  end

  address = server.bind_tcp "0.0.0.0", 8080
  puts "Listening on http://#{address}"
  server.listen
end


