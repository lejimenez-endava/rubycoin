ActiveSupport::Reloader.to_prepare do
  $NODE = Core::Node.instance
end

Thread.abort_on_exception = true

Rubycoin::Miscellaneous.every(3.seconds) do
  puts '-------------------', $NODE.blockchain.to_s
end
