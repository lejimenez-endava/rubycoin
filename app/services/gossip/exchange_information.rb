module Gossip
  class ExchangeInformation
    #
    # example
    #
    # success, data = Gossip::ExchangeInformation.new.call(node, params)
    #
    # # success #=> true
    # data[:information] #=> { blockchain: ###, peers: ### }
    #
    # # success #=> false
    # data[:information] #=> {}
    #
    def call(node, data = {})
      node.update_blockchain YAML.load(data[:blockchain])
      node.update_peers data[:peers]
      [
        true,
        {
          information: {
            blockchain: YAML.dump(node.blockchain),
            peers: node.peers
          }
        }
      ]
    rescue StandardError => e
      [
        false,
        { error: e, information: {} }
      ]
    end
  end
end
