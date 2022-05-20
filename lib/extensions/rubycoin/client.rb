module Rubycoin
  module Client
    URL = 'http://localhost'

    def gossip(port, peers, blockchain)
      begin
        Faraday.post("#{URL}:#{port}/core/node/gossip", gossip: { peers: peers, blockchain: YAML.dump(blockchain) }).body
      rescue Faraday::ConnectionFailed => e
        raise
      end
    end

    def fetch_public_information
    end

    module_function :gossip, :fetch_public_information
  end
end
