require 'em-websocket'
require 'json'

EM.run do
  Synth = nil

  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
    puts "*** connect phone app to :8080."

    ws.onopen { |handshake|
      puts "*** Connection from phone on #{handshake.path}"
    }

    ws.onclose { puts "Connection closed from phone." }

    ws.onmessage { |msg|
      # m = JSON.parse(msg)

      if Synth
        puts "to Synth: #{msg}"
        Synth.send msg
        # case m['x'].to_i
        # when 3..10
        #   puts "#{m['x']} => Synth 1"
        #   Synth.send '1'
        # when 11..29
        #   puts "#{m['x']} => Synth 2"
        #   Synth.send '2'
        # when 30..100
        #   puts "#{m['x']} => Synth 3"
        #   Synth.send '3'
        # end
      end
    }
  end

  EM::WebSocket.run(:host => "0.0.0.0", :port => 9090) do |ws|
    puts "*** connect synth app to :9090."
    ws.onopen { |handshake|
      puts "*** Connection from Synth app OK"
      Synth = ws
    }

    ws.onclose { puts "Connection closed from Synth app." }

  end

  puts "*** websockets servers started."
end
