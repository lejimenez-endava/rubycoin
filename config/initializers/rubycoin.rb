ActiveSupport::Reloader.to_prepare do
  $NODE = Core::Node.instance
end

Thread.abort_on_exception = true

Rubycoin::Miscellaneous.every(3.seconds) do
  Gossip::SpreadWithPeers.new.call($NODE) if $NODE.port.present?
end
