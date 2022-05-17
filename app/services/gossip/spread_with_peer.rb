module Gossip
  class SpreadWithPeer
    def call(node, port)
      response = Rubycoin::Client.gossip port, node.peers, node.blockchain
      # a = JSON.parse(response)
      # Gossip::ExchangeInformation.new.call node, { their_blockchain: response[:blockchain], their_peers: response[:peers] }
      binding.break
    end
  end
end
