module Gossip
  class SpreadWithPeers
    def call(node)
      node.peers.dup.each do |port|
        next if port == node.port
        
        puts "Gossiping about blockchain and peers with PORT> #{port}"
        Gossip::SpreadWithPeer.new.call node, port
      end
    end
  end
end
