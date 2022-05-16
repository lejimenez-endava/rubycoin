module Core
  class Node
    include Singleton

    attr_reader :private_key, :public_key, :peers, :blockchain, :name, :port

    def initialize

    end
  end
end
