module Core
  class NodesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def gossip
      success, data = Gossip::ExchangeInformation.new.call $NODE, gossip_params
      render json: data[:information], status: success
    end

    private

    def gossip_params
      params.require(:gossip).permit [:blockchain, { peers: [] }]
    end
  end
end
