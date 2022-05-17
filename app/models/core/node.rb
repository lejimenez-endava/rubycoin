module Core
  class Node
    include Singleton

    attr_reader :private_key, :public_key, :peers, :blockchain, :name, :port

    def initialize
      @private_key, @public_key = Rubycoin::PKI.generate_key_pair
      @port = Rails::Server::Options.new.parse!(ARGV)[:Port] rescue nil # PAIRING_PORT=3032 rs -p 3000
      @peers = ThreadSafe::Array.new([port])
      # port does not exist when TCPServer is not initialized
      initial_setup if @port.present?
      puts blockchain.to_s
    end

    def update_blockchain(their_blockchain)
      return if their_blockchain.nil?
      return if @blockchain && their_blockchain.length <= @blockchain.length
      return unless their_blockchain.valid?

      @blockchain = their_blockchain
    end

    def update_peers(their_peers)
      @peers = (@peers + their_peers).uniq
    end

    private

    def initial_setup
      peer_port = ENV['PEER_PORT'].to_i
      message = if peer_port.zero? # genesis
                  @blockchain = Core::Blockchain.new(public_key, private_key)
                  'you are the progenitor'
                else
                  peers.push(peer_port)
                  "You are paired with #{peer_port}"
                end
      puts "\n#{message}\n"
    end
  end
end
