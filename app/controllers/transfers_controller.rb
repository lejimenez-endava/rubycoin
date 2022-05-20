class TransfersController < ApplicationController
  def create
    to = params[:to]
    amount = params[:amount]
    success, data = CreateTransfer.new.call $NODE, to, amount
    render plain: "#{success}", status: 200
  end
end
