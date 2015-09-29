require 'em-websocket'

EM.run do
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen { |handshake|
      puts "*** Connection opened from #{handshake.path}"
    }

    ws.onclose { puts "Connection closed." }

    ws.onmessage { |msg|
      puts "[data] #{msg}"
    }
  end
end
