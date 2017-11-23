class MicroCommute
  def initialize(msg = {})
    @msg = msg
  end
  # Micro::Broadcaster.new.ping
  def publish
    puts "~~~~~~~~~->   Start sending of #{@msg}"
    conn = connection
    conn.start
    ch   = conn.create_channel
    x    = ch.direct("ruby_hat")
    x.publish(@msg)
    puts " [x] Sent #{@msg}"
    conn.close
  end

  def receive
    conn = Bunny.new
    conn.start
    ch   = conn.create_channel
    x   = ch.fanout("logs")
    q   = ch.queue("", :exclusive => true)
    q.bind(x)
    begin
      q.subscribe(:block => true) do |delivery_info, properties, body|
        puts " [x] #{body}"
      end
    rescue Interrupt => _
      ch.close
      conn.close
    end
  end

  def connection
    if Rails.env.development?
      Bunny.new
    else
      Bunny.new Rails.application.secrets.rabbit_url
    end
  end
end
