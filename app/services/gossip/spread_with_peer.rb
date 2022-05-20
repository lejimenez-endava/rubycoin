module Gossip
  class SpreadWithPeer
    def call(node, port)
      raw_response = Rubycoin::Client.gossip port, node.peers, node.blockchain
      response = JSON.parse(raw_response)
      Gossip::ExchangeInformation.new.call node, { blockchain: response[:blockchain], peers: response[:peers] }
    end
  end
end
