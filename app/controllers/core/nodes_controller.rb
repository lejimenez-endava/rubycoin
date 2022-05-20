module Core
  class NodesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def gossip
      success, data = Gossip::ExchangeInformation.new.call $NODE, gossip_params
      binding.break
      render json: data[:information], status: (success ? 200 : 500)
    end

    private

    def gossip_params
      params.require(:gossip).permit [:blockchain, { peers: [] }]
    end
  end
end
