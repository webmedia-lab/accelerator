require 'em-websocket'
require 'json'

EM.run do
  sound = nil

  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen { |handshake|
      puts "*** Connection opened from #{handshake.path}"
    }

    ws.onclose { puts "Connection closed from device." }

    ws.onmessage { |msg|
      m = JSON.parse(msg)

      if sound
        case m['x'].to_i
        when 3..10
          puts "#{m['x']} => sound 1"
          sound.send '1'
        when 11..29
          puts "#{m['x']} => sound 2"
          sound.send '2'
        when 30..100
          puts "#{m['x']} => sound 3"
          sound.send '3'
        end
      end
    }
  end

  EM::WebSocket.run(:host => "0.0.0.0", :port => 9090) do |ws|
    ws.onopen { |handshake|
      puts "*** Connection from sound app OK"
      sound = ws
    }

    ws.onclose { puts "Connection closed from sound app." }

  end

end
